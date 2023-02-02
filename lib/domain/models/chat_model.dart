// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    required List<String> deleted,
    required List<String> readReceipt,
    required List<String> users,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json)
  => _$ChatModelFromJson(json);
}
