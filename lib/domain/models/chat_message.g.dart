// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      senderName: json['senderName'] as String,
      senderID: json['senderID'] as String,
      createdAt:
          DateTime.parse(getMessageTimeCreation(json, 'created') as String),
      id: json['id'] as String,
      content: json['content'] as String,
      isMyMessage: json['isMyMessage'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'senderName': instance.senderName,
      'senderID': instance.senderID,
      'created': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'content': instance.content,
      'isMyMessage': instance.isMyMessage,
    };
