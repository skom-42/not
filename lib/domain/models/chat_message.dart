import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String senderName,
    required String senderID,
    @JsonKey(name: 'created', readValue: getMessageTimeCreation)
        required DateTime createdAt,
    required String id,
    required String content,
    @JsonKey(defaultValue: false) required bool isMyMessage,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) => _$ChatMessageFromJson(json);
}

String getMessageTimeCreation(Map<dynamic, dynamic> data, String key) {
  if (data[key] != null) {
    final Timestamp time = data[key];
    return DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch)
        .toIso8601String();
  }

  return DateTime.now().toIso8601String();
}
