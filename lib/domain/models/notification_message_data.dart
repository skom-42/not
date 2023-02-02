import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_message_data.freezed.dart';
part 'notification_message_data.g.dart';

@freezed
class NotificationMessageData with _$NotificationMessageData {
  const factory NotificationMessageData({
    @JsonKey(defaultValue: '') required String title,
    @JsonKey(defaultValue: '') required String body,
    @JsonKey(defaultValue: '') required String subtitle,
    @JsonKey(defaultValue: '') required String plate,
  }) = _NotificationMessageData;

  factory NotificationMessageData.fromJson(Map<String, Object?> json) =>
      _$NotificationMessageDataFromJson(json);
}
