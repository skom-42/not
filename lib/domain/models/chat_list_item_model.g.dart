// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatListItemModel _$$_ChatListItemModelFromJson(Map<String, dynamic> json) =>
    _$_ChatListItemModel(
      docId: json['docId'] as String,
      plate: json['plate'] as String,
      readReceiptUsers: json['readReceiptUsers'] as List<dynamic>? ?? [],
      blocked: json['blocked'] as List<dynamic>? ?? [],
      user: json['user'] == null
          ? null
          : CustomUser.fromJson(json['user'] as Map<String, dynamic>),
      toUser: json['toUser'] == null
          ? null
          : CustomUser.fromJson(json['toUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChatListItemModelToJson(
        _$_ChatListItemModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'plate': instance.plate,
      'readReceiptUsers': instance.readReceiptUsers,
      'blocked': instance.blocked,
      'user': instance.user,
      'toUser': instance.toUser,
    };
