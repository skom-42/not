import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_user.freezed.dart';
part 'custom_user.g.dart';

@freezed
class CustomUser with _$CustomUser {
  const factory CustomUser({
    @JsonKey(defaultValue: '') required String email,
    @JsonKey(defaultValue: false) required bool isVerified,
    @JsonKey(defaultValue: null) required String? name,
    @JsonKey(defaultValue: null) required String? surname,
    @JsonKey(defaultValue: '') required String notificationToken,
    @JsonKey(defaultValue: null) required String? plate,
    @JsonKey(defaultValue: 0) required int registrationDate,
    @JsonKey(defaultValue: '') required String documentId,
  }) = _CustomUser;

  factory CustomUser.fromJson(Map<String, Object?> json) => _$CustomUserFromJson(json);
}
