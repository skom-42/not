import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/utils/notification_service.dart';
import 'package:noty_mobile/data/firebase_api_provider.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> initDependencies() async {
    appLocator.registerSingleton<FirebaseApiProvider>(
      FirebaseApiProvider(),
    );

    appLocator.registerSingleton<AuthRepository>(
      AuthRepository(
        firebaseApiProvider: appLocator<FirebaseApiProvider>(),
      ),
    );

    appLocator.registerSingleton<NotificationService>(
      NotificationService()..initNotifications(),
    );

    appLocator.registerSingleton<ChatRepository>(
      ChatRepository(
        apiProvider: appLocator<FirebaseApiProvider>(),
      ),
    );
  }
}
