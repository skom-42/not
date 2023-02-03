// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  List<String>? get deleted => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<String> get readReceipt => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<String> get blocked => throw _privateConstructorUsedError;
  List<String> get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {List<String>? deleted,
      @JsonKey(defaultValue: []) List<String> readReceipt,
      @JsonKey(defaultValue: []) List<String> blocked,
      List<String> users});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleted = freezed,
    Object? readReceipt = null,
    Object? blocked = null,
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      deleted: freezed == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      readReceipt: null == readReceipt
          ? _value.readReceipt
          : readReceipt // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as List<String>,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$$_ChatModelCopyWith(
          _$_ChatModel value, $Res Function(_$_ChatModel) then) =
      __$$_ChatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? deleted,
      @JsonKey(defaultValue: []) List<String> readReceipt,
      @JsonKey(defaultValue: []) List<String> blocked,
      List<String> users});
}

/// @nodoc
class __$$_ChatModelCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$_ChatModel>
    implements _$$_ChatModelCopyWith<$Res> {
  __$$_ChatModelCopyWithImpl(
      _$_ChatModel _value, $Res Function(_$_ChatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deleted = freezed,
    Object? readReceipt = null,
    Object? blocked = null,
    Object? users = null,
  }) {
    return _then(_$_ChatModel(
      deleted: freezed == deleted
          ? _value._deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      readReceipt: null == readReceipt
          ? _value._readReceipt
          : readReceipt // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blocked: null == blocked
          ? _value._blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as List<String>,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatModel with DiagnosticableTreeMixin implements _ChatModel {
  const _$_ChatModel(
      {final List<String>? deleted,
      @JsonKey(defaultValue: []) required final List<String> readReceipt,
      @JsonKey(defaultValue: []) required final List<String> blocked,
      required final List<String> users})
      : _deleted = deleted,
        _readReceipt = readReceipt,
        _blocked = blocked,
        _users = users;

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatModelFromJson(json);

  final List<String>? _deleted;
  @override
  List<String>? get deleted {
    final value = _deleted;
    if (value == null) return null;
    if (_deleted is EqualUnmodifiableListView) return _deleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _readReceipt;
  @override
  @JsonKey(defaultValue: [])
  List<String> get readReceipt {
    if (_readReceipt is EqualUnmodifiableListView) return _readReceipt;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readReceipt);
  }

  final List<String> _blocked;
  @override
  @JsonKey(defaultValue: [])
  List<String> get blocked {
    if (_blocked is EqualUnmodifiableListView) return _blocked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocked);
  }

  final List<String> _users;
  @override
  List<String> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatModel(deleted: $deleted, readReceipt: $readReceipt, blocked: $blocked, users: $users)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatModel'))
      ..add(DiagnosticsProperty('deleted', deleted))
      ..add(DiagnosticsProperty('readReceipt', readReceipt))
      ..add(DiagnosticsProperty('blocked', blocked))
      ..add(DiagnosticsProperty('users', users));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatModel &&
            const DeepCollectionEquality().equals(other._deleted, _deleted) &&
            const DeepCollectionEquality()
                .equals(other._readReceipt, _readReceipt) &&
            const DeepCollectionEquality().equals(other._blocked, _blocked) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_deleted),
      const DeepCollectionEquality().hash(_readReceipt),
      const DeepCollectionEquality().hash(_blocked),
      const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      __$$_ChatModelCopyWithImpl<_$_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatModelToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {final List<String>? deleted,
      @JsonKey(defaultValue: []) required final List<String> readReceipt,
      @JsonKey(defaultValue: []) required final List<String> blocked,
      required final List<String> users}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  List<String>? get deleted;
  @override
  @JsonKey(defaultValue: [])
  List<String> get readReceipt;
  @override
  @JsonKey(defaultValue: [])
  List<String> get blocked;
  @override
  List<String> get users;
  @override
  @JsonKey(ignore: true)
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
