// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationMessageData _$$_NotificationMessageDataFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationMessageData(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      plate: json['plate'] as String? ?? '',
    );

Map<String, dynamic> _$$_NotificationMessageDataToJson(
        _$_NotificationMessageData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'subtitle': instance.subtitle,
      'plate': instance.plate,
    };
