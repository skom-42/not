import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/data/custom_exception.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';
import 'package:noty_mobile/features/auth/login%20/ui/login_page.dart';
import 'package:http/http.dart' as http;

class FirebaseApiProvider {
  static final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final FirebaseMessaging _firebaseMessagingInstance = FirebaseMessaging.instance;

  late User? currentUser;
  CustomUser? customUser;
  String? updatedPlates;

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
    required String surName,
  }) async {
    try {
      final UserCredential newUser = await _firebaseAuthInstance.createUserWithEmailAndPassword(
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
      final UserCredential userCredential = await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = userCredential.user;
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
    return email == null ? "Unknown" : email.split('@')[0];
  }

  String _getRegistrationDate() {
    return DateTime.now().microsecondsSinceEpoch.toString();
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

  Future<CustomUser?> getUserAttributes() async {
    final b = await _firestoreInstance.collection('Users').doc(_getUsername()).get();

    if (b.data() != null) {
      final data = b.data() as Map<String, dynamic>;
      final String? email = data['email'] as String?;
      if (email == null) {
        await deleteCurrentUser();
        await logOut();
        appLocator<AppRouterDelegate>().push(LoginPage());
      }

      customUser = CustomUser(
        email: data['email'] as String,
        isVerified: data['isVerified'] as bool,
        name: data['name'] as String?,
        surname: data['surname'] as String?,
        notificationToken: data['notificationToken'] as String,
        plate: data['plate'] as String?,
        registrationDate: int.parse(data['registrationDate'] as String),
        documentId: b.id,
      );
    }

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

  Future<bool> getPlate() async {
    final DocumentSnapshot result =
        await _firestoreInstance.collection('Users').doc(_getUsername()).get();
    final Map<String, dynamic> parsedData = result.data() as Map<String, dynamic>;
    final String? plate = parsedData['plate'] as String?;
    return plate != null;
  }

  Future<List> getAllChats() async {
    return [];
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
      customUser = customUser?.copyWithNewPlate(plate: plate);
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
      customUser = customUser?.updateIsVerified();
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
