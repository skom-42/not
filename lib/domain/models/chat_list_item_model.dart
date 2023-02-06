// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';

part 'chat_list_item_model.freezed.dart';
part 'chat_list_item_model.g.dart';

@freezed
class ChatListItemModel with _$ChatListItemModel {
  const factory ChatListItemModel({
    required String docId,
    required String plate,
    @JsonKey(defaultValue: []) required List readReceiptUsers,
    @JsonKey(defaultValue: []) required List blocked,
    CustomUser? user,
    CustomUser? toUser,
  }) = _ChatListItemModel;

  factory ChatListItemModel.fromJson(Map<String, Object?> json) =>
      _$ChatListItemModelFromJson(json);
}
