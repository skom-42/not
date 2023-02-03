import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/data/custom_exception.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/domain/models/chat_message.dart';
import 'package:noty_mobile/domain/models/chat_model.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';
import 'package:noty_mobile/features/auth/login%20/ui/login_page.dart';

class FirebaseApiProvider {
  static final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final FirebaseMessaging _firebaseMessagingInstance = FirebaseMessaging.instance;

  User? currentUser;
  CustomUser? customUser;
  String? updatedPlates;
  StreamController<List<ChatListItemModel>>? chatStream;
  StreamController<List<ChatMessage>>? chatMessagesStream;

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
    required String surName,
  }) async {
    try {
      final UserCredential newUser =
          await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = newUser.user;

      await _createNewUser(
        name: name,
        surname: surName,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isUserLoggedIn() {
    final User? user = _firebaseAuthInstance.currentUser;
    if (user != null) {
      currentUser = user;
    }
    return user != null;
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
      await updateToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'This user account has been disabled by the admin.',
          ),
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'The password is invalid.',
          ),
        );
      } else if (e.code == 'invalid-email') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'The email address is malformed',
          ),
        );
      } else {
        throw CustomException(errorMessage: e.message ?? '');
      }
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final String? accessToken = googleAuth?.accessToken;
    final String? idToken = googleAuth?.idToken;
    if (accessToken == null || idToken == null) {
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      return await _authenticateUser(credential: credential);
    }
    return false;
  }

  Future<bool> _authenticateUser({required AuthCredential credential}) async {
    await _firebaseAuthInstance.signInWithCredential(credential);
    final DocumentSnapshot result =
        await _firestoreInstance.collection("Users").doc(_getUsername()).get();
    if (result.exists) {
      return true;
    } else {
      try {
        await _createNewUser(
          name: null,
          surname: null,
        );
        return true;
      } catch (e) {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'Something went wrong while creating the account.',
          ),
        );
      }
    }
  }

  Future<void> logOut() async {
    await _firebaseAuthInstance.signOut();
  }

  Future<void> updateToken() async {
    final String? token = await _firebaseMessagingInstance.getToken();
    print('%FB TOKEN% ${token}');
    if (token != null) {
      _firestoreInstance.collection("Users").doc(_getUsername()).set(
        <String, dynamic>{
          'notificationToken': token,
        },
        SetOptions(merge: true),
      );
    }
  }

  Future<void> _createNewUser({required String? name, required String? surname}) async {
    final String? token = await _firebaseMessagingInstance.getToken();
    _firestoreInstance.collection("Users").doc(_getUsername()).set(
      <String, dynamic>{
        'notificationToken': token!,
        'email': currentUser?.email ?? '',
        'registrationDate': _getRegistrationDate(),
        'isVerified': false,
        'name': name,
        'surname': surname,
      },
      SetOptions(merge: true),
    );
    return;
  }

  String _getUsername() {
    final String? email = currentUser?.email;
    return email == null ? "Unknown" : email;
  }

  int _getRegistrationDate() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuthInstance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'This user account has been disabled by the admin.',
          ),
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'The password is invalid.',
          ),
        );
      } else if (e.code == 'invalid-email') {
        throw CustomException(
          errorMessage: AppLocalizations.ofGlobalContext(
            'The email address is malformed',
          ),
        );
      } else {
        throw CustomException(errorMessage: e.message ?? '');
      }
    }
  }

  Future<CustomUser?> getUserByPlate({required String plate}) async {
    final db = await _firestoreInstance
        .collection("Users")
        .where('plate', isEqualTo: plate)
        .get();

    if (db.docs.isNotEmpty) {
      return CustomUser.fromJson(db.docs.first.data());
    }
    return null;
  }

  Future<CustomUser?> getUserByName({required String name}) async {
    final data = await _firestoreInstance.collection('Users').doc(name).get();
    final userData = data.data();
    if (userData != null) {
      return CustomUser.fromJson(userData);
    }
    return null;
  }

  Future<CustomUser?> getUserInChat({required ChatModel chat}) async {
    final String name = chat.users.firstWhere((element) => element != _getUsername());
    final data = await _firestoreInstance.collection('Users').doc(name).get();
    final userData = data.data();
    if (userData != null) {
      return CustomUser.fromJson(userData);
    }
    return null;
  }

  Future<CustomUser?> getUserAttributes() async {
    final b = await _firestoreInstance.collection('Users').doc(_getUsername()).get();

    try {
      if (b.data() != null) {
        final data = b.data() as Map<String, dynamic>;
        final String? email = data['email'] as String?;
        if (email == null) {
          // await deleteCurrentUser();
          await logOut();
          appLocator<AppRouterDelegate>().push(LoginPage());
        }
        print('%data% ${data}');

        customUser = CustomUser(
          email: data['email'] as String,
          isVerified: data['isVerified'] as bool,
          name: data['name'] as String?,
          surname: data['surname'] as String?,
          notificationToken: data['notificationToken'] as String,
          plate: data['plate'] as String?,
          registrationDate: data['registrationDate'],
          documentId: b.id,
        );
      }
    } catch (e) {
      print('%getUserAttributes% ${e.toString()}');
    }

    print('%customUser% ${customUser.toString()}');
    return customUser;
  }

  Future<void> deleteCurrentUser() async {
    await _firestoreInstance.collection("Users").doc(_getUsername()).delete();
    try {
      await _firebaseAuthInstance.currentUser?.delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> getPlate({String? userName}) async {
    final DocumentSnapshot result = await _firestoreInstance
        .collection('Users')
        .doc(userName ?? _getUsername())
        .get();
    final Map<String, dynamic> parsedData = result.data() as Map<String, dynamic>;
    final String? plate = parsedData['plate'] as String?;
    return plate != null;
  }

  Future<String?> getUserPlate(String username) async {
    print('%getUserPlate% ${username}');
    try {
      final DocumentSnapshot snapshot =
          await _firestoreInstance.collection("Users").doc(username).get();
      final Map<String, dynamic> parsedData = snapshot.data() as Map<String, dynamic>;
      return parsedData['plate'] as String?;
    } catch (e) {
      print('%getUserPlate error% ${e.toString()}');
    }
    return null;
  }

  Future<Stream<List<ChatListItemModel>>> getAllChats() async {
    chatStream?.close();
    chatStream = null;
    chatStream = StreamController<List<ChatListItemModel>>();
    final db = _firestoreInstance
        .collection("Chats")
        .where("users", arrayContains: _getUsername());
    db.snapshots().listen((event) async {
      final queryCount = event.docs.length;
      if (queryCount >= 1) {
        final List<ChatListItemModel> result = [];
        for (final doc in event.docs) {
          try {
            final ChatModel chat = ChatModel.fromJson(doc.data());
            if (!(chat.deleted?.contains(_getUsername()) ?? false)) {
              final String? plate = await getUserPlate(
                chat.users.firstWhere(
                  (elem) => elem != _getUsername(),
                ),
              );
              final CustomUser? toUser = await getUserInChat(chat: chat);
              if (plate != null) {
                final ChatListItemModel chatItem = ChatListItemModel(
                  docId: doc.id,
                  plate: plate,
                  readReceiptUsers: chat.readReceipt,
                  toUser: toUser,
                  blocked: chat.blocked,
                  user: customUser,
                );
                result.add(chatItem);
              }
            }
          } catch (e) {
            print('%getAllChats error% ${e.toString()}');
          }
        }
        chatStream?.add(result);
      }
    });
    return chatStream!.stream;
  }

  Future<ChatListItemModel> createChat({
    required String plate,
  }) async {
    final CustomUser? recepient = await getUserByPlate(plate: plate.toUpperCase().trim());
    if (recepient == null) {
      throw CustomException(
        errorMessage: AppLocalizations.ofGlobalContext(
          'Plate not found.',
        ),
      );
    }
    final List<String> users = [_getUsername(), recepient.email];
    final Map<String, dynamic> data = {
      "users": users.toSet().toList(),
      "readReceipt": [],
      "deleted": [],
    };
    final CollectionReference db = _firestoreInstance.collection("Chats");
    final ref = await db.add(data);
    final chat = await ref.get();
    final chatData = chat.data() as Map<String, dynamic>;

    final ChatListItemModel chatItem = ChatListItemModel(
      docId: chat.id,
      plate: plate,
      blocked: chatData['blocked'] ?? [],
      user: customUser,
      readReceiptUsers: chatData['readReceipt'] ?? [],
      toUser: recepient,
    );
    return chatItem;
  }

  Future<ChatListItemModel> getChat({
    required String plate,
  }) async {
    final CustomUser? recepient = await getUserByPlate(plate: plate.toUpperCase().trim());
    if (recepient == null) {
      throw CustomException(
        errorMessage: AppLocalizations.ofGlobalContext(
          'Plate not found.',
        ),
      );
    }
    ChatListItemModel chatItem;

    final db = await _firestoreInstance
        .collection("Chats")
        .where("users", arrayContains: _getUsername())
        .get();
    for (final doc in db.docs) {
      final ChatModel chat = ChatModel.fromJson(doc.data());

      if (chat.users.contains(recepient.email)) {
        try {
          chatItem = ChatListItemModel(
            docId: doc.id,
            plate: plate,
            readReceiptUsers: chat.readReceipt,
            toUser: recepient,
            blocked: chat.blocked,
            user: customUser,
          );
          return chatItem;
        } catch (e) {
          print('%getChat error% ${e.toString()}');
        }
      }
    }

    return await createChat(plate: plate);
  }

  Future<void> blockUser({
    required ChatListItemModel chat,
  }) async {
    _firestoreInstance.collection("Chats").doc(chat.docId).update({
      "blocked": FieldValue.arrayUnion([_getUsername()]),
      "deleted": FieldValue.arrayUnion([_getUsername(), chat.toUser?.email ?? "Unknown"])
    });
  }

  Future<bool> deleteChat(ChatListItemModel chat) async {
    _firestoreInstance.collection("Chats").doc(chat.docId).update({
      "deleted": FieldValue.arrayUnion([_getUsername()])
    });
    return true;
  }

  Future<void> sendMessage({
    required String message,
    required ChatListItemModel chat,
  }) async {
    _firestoreInstance.collection("Chats").doc(chat.docId).update({"deleted": []});
    var notifPayload = {
      "to": chat.toUser?.notificationToken ?? "",
      "data": {
        "title": "Noty",
        "body": message,
        "subtitle": _getUsername(),
        "badge": 1,
        "sound": "owl",
        "plate": customUser?.plate ?? "",
      },
      "notification": {
        "title": "Noty",
        "body": message,
        "subtitle": _getUsername(),
        "badge": 1,
        "sound": "owl.mp3",
        "plate": customUser?.plate ?? "",
        "android": {
          'channelId': "noty_mobile",
          'priority': 1,
          'sound': 'owl',
          'visibility': 1,
        }
      },
      "android": {
        'channelId': "noty_mobile",
        'priority': 1,
        'sound': 'owl',
        'visibility': 1,
      }
    };

    final Map<String, dynamic> data = {
      "content": message,
      "created": Timestamp.now(),
      "id": _getUsername() + DateTime.now().millisecondsSinceEpoch.toString(),
      "senderID": _getUsername(),
      "senderName": customUser?.plate ?? ''
    };
    if (currentChat == null) {
      print('%null}');
    }
    final db = await currentChat?.collection("thread").get();

    await currentChat?.collection("thread").add(data);
    updateReadReceiptStatus(isSent: true, recieverId: chat.toUser?.email);
    sendPushNotification(notifPayload);
  }

  Future<void> sendPushNotification(Map<String, dynamic> payloadDict) async {
    final url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final request = http.Request("POST", url);
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] =
        "key=AAAAPbVYdRI:APA91bHY1BBI2xVRiwrqkzUgirzPrianLzp440al3U55o895nghHTBUBQoXlwUQYXZL1_gSI_usyVpFHoR8S4XCrFsUbfxC3d-A_4K1rui0WRY18xPEmw2lbn89Miid0VOCGr6bQBrh7";
    request.body = jsonEncode(payloadDict);
    await http.Response.fromStream(await request.send());
  }

  DocumentReference? currentChat;

  Future<Stream<List<ChatMessage>>> getChatMessages({
    required ChatListItemModel chatListItemModel,
  }) async {
    chatMessagesStream?.close();
    chatMessagesStream = null;
    chatMessagesStream = StreamController<List<ChatMessage>>();
    final db =
        await _firestoreInstance.collection("Chats").doc(chatListItemModel.docId).get();

    if (db.exists) {
      currentChat = db.reference;
      currentChat
          ?.collection("thread")
          .orderBy("created", descending: true)
          .snapshots()
          .listen((event) {
        updateReadReceiptStatus();

        final List<ChatMessage> result = [];
        for (var message in event.docs) {
          final Map<String, dynamic> mes = message.data();
          if (mes['senderID'] == _getUsername()) {
            mes['isMyMessage'] = true;
          }
          result.add(ChatMessage.fromJson(mes));
        }
        chatMessagesStream!.add(result);
      });
    }

    return chatMessagesStream!.stream;
  }

  void updateReadReceiptStatus({bool isSent = false, String? recieverId}) {
    if (isSent) {
      currentChat?.update({
        "readReceipt": FieldValue.arrayRemove([recieverId ?? "Unknown"])
      });
    } else {
      currentChat?.update({
        "readReceipt": FieldValue.arrayUnion([_getUsername()])
      });
    }
  }

  Future<void> updateUser({
    required String name,
    required String sName,
    required String plate,
  }) async {
    await _firestoreInstance.collection("Users").doc(_getUsername()).set(
      <String, dynamic>{
        'name': name,
        'surname': sName,
        'plate': plate,
      },
      SetOptions(merge: true),
    );
    return;
  }

  Future<String?> updatePlate({required String plate}) async {
    try {
      await _firestoreInstance.collection("Users").doc(_getUsername()).set(
        <String, dynamic>{
          'plate': plate,
        },
        SetOptions(merge: true),
      );
      customUser = customUser?.copyWith(plate: plate);
      return plate;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateIsVerified() async {
    try {
      await _firestoreInstance.collection("Users").doc(_getUsername()).set(
        <String, dynamic>{
          'isVerified': true,
        },
        SetOptions(merge: true),
      );
      customUser = customUser?.copyWith(isVerified: true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? getUpdatedPlate() {
    return updatedPlates;
  }

  Future<bool> checkForValidXml({required String plate}) async {
    final String? plate = customUser?.plate;
    if (plate != null) {
      try {
        final http.Response response = await http.post(
          Uri.parse('http://www.targa.co.it/api/reg.asmx/CheckItaly'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'RegistrationNumber': plate,
            'username': 'noty',
          }),
        );
        print('VEREFY RESPONCE');
        final String xmlResponse = response.body.toString();
        print(xmlResponse);

        print('VEREFY RESPONCE');
        if (xmlResponse.contains('"CurrentTextValue": "Elettrica"')) {
          return true;
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return false;
  }
}
