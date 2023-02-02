import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/domain/models/notification_message_data.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_page.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService()
    ..initNotifications()
    ..showNotification(message);
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance
    ..setAutoInitEnabled(true);
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _requestPermissions();
    await _setUpFirebaseMassageListener();
  }

  Future<void> _requestPermissions() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await flutterLocalNotificationsPlugin.initialize(
      // @mipmap/ic_launcher
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        print('%print% ${notificationResponse.payload.toString()}');
        _onMessageOpenApp(
          RemoteMessage(
            data: jsonDecode(notificationResponse.payload ?? ''),
          ),
        );
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> getInitialMessage() async {
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenApp(initialMessage);
    }
  }

  Future<void> _setUpFirebaseMassageListener() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        showNotification(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static Future<void> _onMessageOpenApp(RemoteMessage? message) async {
    if (message != null) {
      final NotificationMessageData notification =
          NotificationMessageData.fromJson(message.data);
      final ChatListItemModel? chat =
          await appLocator<ChatRepository>().getChat(plate: notification.plate);
      if (chat != null) {
        appLocator<AppRouterDelegate>().push(DialogPage(chatModel: chat));
      }
    }
  }

  void showNotification(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    // final RemoteNotification? notification = message.notification;
    final RemoteNotification notification = RemoteNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        android: const AndroidNotification(
          sound: 'owl',
          visibility: AndroidNotificationVisibility.public,
          priority: AndroidNotificationPriority.highPriority,
          channelId: 'noty_mobile',
        ));

    print('%print% ${notification.toMap()}');
    print('%message% ${message.toMap()}');

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'noty_mobile',
            'noty_mobile_channel',
            channelDescription: 'channel noty_mobile',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            groupKey: 'noty',
            visibility: NotificationVisibility.public,
            playSound: true,
            sound: RawResourceAndroidNotificationSound("owl"),
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }
}
