// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatListItemModel _$ChatListItemModelFromJson(Map<String, dynamic> json) {
  return _ChatListItemModel.fromJson(json);
}

/// @nodoc
mixin _$ChatListItemModel {
  String get docId => throw _privateConstructorUsedError;
  String get plate => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<dynamic> get readReceiptUsers => throw _privateConstructorUsedError;
  CustomUser? get toUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatListItemModelCopyWith<ChatListItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListItemModelCopyWith<$Res> {
  factory $ChatListItemModelCopyWith(
          ChatListItemModel value, $Res Function(ChatListItemModel) then) =
      _$ChatListItemModelCopyWithImpl<$Res, ChatListItemModel>;
  @useResult
  $Res call(
      {String docId,
      String plate,
      @JsonKey(defaultValue: []) List<dynamic> readReceiptUsers,
      CustomUser? toUser});

  $CustomUserCopyWith<$Res>? get toUser;
}

/// @nodoc
class _$ChatListItemModelCopyWithImpl<$Res, $Val extends ChatListItemModel>
    implements $ChatListItemModelCopyWith<$Res> {
  _$ChatListItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? plate = null,
    Object? readReceiptUsers = null,
    Object? toUser = freezed,
  }) {
    return _then(_value.copyWith(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      plate: null == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String,
      readReceiptUsers: null == readReceiptUsers
          ? _value.readReceiptUsers
          : readReceiptUsers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      toUser: freezed == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as CustomUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomUserCopyWith<$Res>? get toUser {
    if (_value.toUser == null) {
      return null;
    }

    return $CustomUserCopyWith<$Res>(_value.toUser!, (value) {
      return _then(_value.copyWith(toUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatListItemModelCopyWith<$Res>
    implements $ChatListItemModelCopyWith<$Res> {
  factory _$$_ChatListItemModelCopyWith(_$_ChatListItemModel value,
          $Res Function(_$_ChatListItemModel) then) =
      __$$_ChatListItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docId,
      String plate,
      @JsonKey(defaultValue: []) List<dynamic> readReceiptUsers,
      CustomUser? toUser});

  @override
  $CustomUserCopyWith<$Res>? get toUser;
}

/// @nodoc
class __$$_ChatListItemModelCopyWithImpl<$Res>
    extends _$ChatListItemModelCopyWithImpl<$Res, _$_ChatListItemModel>
    implements _$$_ChatListItemModelCopyWith<$Res> {
  __$$_ChatListItemModelCopyWithImpl(
      _$_ChatListItemModel _value, $Res Function(_$_ChatListItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? plate = null,
    Object? readReceiptUsers = null,
    Object? toUser = freezed,
  }) {
    return _then(_$_ChatListItemModel(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      plate: null == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String,
      readReceiptUsers: null == readReceiptUsers
          ? _value._readReceiptUsers
          : readReceiptUsers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      toUser: freezed == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as CustomUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatListItemModel implements _ChatListItemModel {
  const _$_ChatListItemModel(
      {required this.docId,
      required this.plate,
      @JsonKey(defaultValue: []) required final List<dynamic> readReceiptUsers,
      this.toUser})
      : _readReceiptUsers = readReceiptUsers;

  factory _$_ChatListItemModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatListItemModelFromJson(json);

  @override
  final String docId;
  @override
  final String plate;
  final List<dynamic> _readReceiptUsers;
  @override
  @JsonKey(defaultValue: [])
  List<dynamic> get readReceiptUsers {
    if (_readReceiptUsers is EqualUnmodifiableListView)
      return _readReceiptUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readReceiptUsers);
  }

  @override
  final CustomUser? toUser;

  @override
  String toString() {
    return 'ChatListItemModel(docId: $docId, plate: $plate, readReceiptUsers: $readReceiptUsers, toUser: $toUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatListItemModel &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.plate, plate) || other.plate == plate) &&
            const DeepCollectionEquality()
                .equals(other._readReceiptUsers, _readReceiptUsers) &&
            (identical(other.toUser, toUser) || other.toUser == toUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, docId, plate,
      const DeepCollectionEquality().hash(_readReceiptUsers), toUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatListItemModelCopyWith<_$_ChatListItemModel> get copyWith =>
      __$$_ChatListItemModelCopyWithImpl<_$_ChatListItemModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatListItemModelToJson(
      this,
    );
  }
}

abstract class _ChatListItemModel implements ChatListItemModel {
  const factory _ChatListItemModel(
      {required final String docId,
      required final String plate,
      @JsonKey(defaultValue: []) required final List<dynamic> readReceiptUsers,
      final CustomUser? toUser}) = _$_ChatListItemModel;

  factory _ChatListItemModel.fromJson(Map<String, dynamic> json) =
      _$_ChatListItemModel.fromJson;

  @override
  String get docId;
  @override
  String get plate;
  @override
  @JsonKey(defaultValue: [])
  List<dynamic> get readReceiptUsers;
  @override
  CustomUser? get toUser;
  @override
  @JsonKey(ignore: true)
  _$$_ChatListItemModelCopyWith<_$_ChatListItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}
