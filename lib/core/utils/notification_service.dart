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

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService()
    ..initNotifications()
    ..showNotification(message);
}

@pragma('vm:entry-point')
Future<void> notificationTapBackground(NotificationResponse notificationResponse) async {
  await Firebase.initializeApp();
  NotificationService()
    ..initNotifications()
    ..showNotification(RemoteMessage(
      data: jsonDecode(notificationResponse.payload ?? ''),
    ));
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
    try {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    } catch (e) {}

    await flutterLocalNotificationsPlugin.initialize(
      // @mipmap/ic_launcher
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
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
    flutterLocalNotificationsPlugin.cancelAll();
    if (message != null) {
      final NotificationMessageData notification =
          NotificationMessageData.fromJson(message.data);
      final ChatListItemModel? chat =
          await appLocator<ChatRepository>().getChat(plate: notification.plate);
      if (chat != null) {
        if (chat.blocked.contains(chat.user?.email)) {
          return;
        }
        appLocator<AppRouterDelegate>().push(DialogPage(chatModel: chat));
      }
    }
  }

  void showNotification(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    final RemoteNotification notification = RemoteNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        android: const AndroidNotification(
          sound: 'owl',
          visibility: AndroidNotificationVisibility.public,
          priority: AndroidNotificationPriority.highPriority,
          channelId: 'noty_mobile',
        ));

    final String plate = message.data['plate'] ?? '';
    flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      notification.title,
      '${plate.isNotEmpty ? '$plate: ' : ''}${notification.body}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'noty_mobile',
          'Noty',
          channelDescription: 'Noty notification',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          groupKey: 'noty',
          category: AndroidNotificationCategory.social,
          visibility: NotificationVisibility.public,
          playSound: true,
          sound: RawResourceAndroidNotificationSound("owl"),
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
}
