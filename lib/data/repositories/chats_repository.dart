import 'package:noty_mobile/data/firebase_api_provider.dart';

class ChatRepository {
  final FirebaseApiProvider apiProvider;

  ChatRepository({
    required this.apiProvider,
  });

  Future<List> getAllChatsList() async {
    return await apiProvider.getAllChats();
  }
}
