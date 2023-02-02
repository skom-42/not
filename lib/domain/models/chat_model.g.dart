// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatModel _$$_ChatModelFromJson(Map<String, dynamic> json) => _$_ChatModel(
      deleted:
          (json['deleted'] as List<dynamic>).map((e) => e as String).toList(),
      readReceipt: (json['readReceipt'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ChatModelToJson(_$_ChatModel instance) =>
    <String, dynamic>{
      'deleted': instance.deleted,
      'readReceipt': instance.readReceipt,
      'users': instance.users,
    };
