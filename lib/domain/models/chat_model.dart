// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    List<String>? deleted,
    @JsonKey(defaultValue: []) required List<String> readReceipt,
    @JsonKey(defaultValue: []) required List<String> blocked,
    required List<String> users,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) => _$ChatModelFromJson(json);
}
