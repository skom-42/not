// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomUser _$$_CustomUserFromJson(Map<String, dynamic> json) =>
    _$_CustomUser(
      email: json['email'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      notificationToken: json['notificationToken'] as String? ?? '',
      plate: json['plate'] as String?,
      registrationDate: json['registrationDate'] as int? ?? 0,
      documentId: json['documentId'] as String? ?? '',
    );

Map<String, dynamic> _$$_CustomUserToJson(_$_CustomUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'isVerified': instance.isVerified,
      'name': instance.name,
      'surname': instance.surname,
      'notificationToken': instance.notificationToken,
      'plate': instance.plate,
      'registrationDate': instance.registrationDate,
      'documentId': instance.documentId,
    };
