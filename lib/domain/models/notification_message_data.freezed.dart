// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_message_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationMessageData _$NotificationMessageDataFromJson(
    Map<String, dynamic> json) {
  return _NotificationMessageData.fromJson(json);
}

/// @nodoc
mixin _$NotificationMessageData {
  @JsonKey(defaultValue: '')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get body => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get subtitle => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get plate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationMessageDataCopyWith<NotificationMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMessageDataCopyWith<$Res> {
  factory $NotificationMessageDataCopyWith(NotificationMessageData value,
          $Res Function(NotificationMessageData) then) =
      _$NotificationMessageDataCopyWithImpl<$Res, NotificationMessageData>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String body,
      @JsonKey(defaultValue: '') String subtitle,
      @JsonKey(defaultValue: '') String plate});
}

/// @nodoc
class _$NotificationMessageDataCopyWithImpl<$Res,
        $Val extends NotificationMessageData>
    implements $NotificationMessageDataCopyWith<$Res> {
  _$NotificationMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? subtitle = null,
    Object? plate = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      plate: null == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotificationMessageDataCopyWith<$Res>
    implements $NotificationMessageDataCopyWith<$Res> {
  factory _$$_NotificationMessageDataCopyWith(_$_NotificationMessageData value,
          $Res Function(_$_NotificationMessageData) then) =
      __$$_NotificationMessageDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String body,
      @JsonKey(defaultValue: '') String subtitle,
      @JsonKey(defaultValue: '') String plate});
}

/// @nodoc
class __$$_NotificationMessageDataCopyWithImpl<$Res>
    extends _$NotificationMessageDataCopyWithImpl<$Res,
        _$_NotificationMessageData>
    implements _$$_NotificationMessageDataCopyWith<$Res> {
  __$$_NotificationMessageDataCopyWithImpl(_$_NotificationMessageData _value,
      $Res Function(_$_NotificationMessageData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? subtitle = null,
    Object? plate = null,
  }) {
    return _then(_$_NotificationMessageData(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      plate: null == plate
          ? _value.plate
          : plate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationMessageData implements _NotificationMessageData {
  const _$_NotificationMessageData(
      {@JsonKey(defaultValue: '') required this.title,
      @JsonKey(defaultValue: '') required this.body,
      @JsonKey(defaultValue: '') required this.subtitle,
      @JsonKey(defaultValue: '') required this.plate});

  factory _$_NotificationMessageData.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationMessageDataFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String title;
  @override
  @JsonKey(defaultValue: '')
  final String body;
  @override
  @JsonKey(defaultValue: '')
  final String subtitle;
  @override
  @JsonKey(defaultValue: '')
  final String plate;

  @override
  String toString() {
    return 'NotificationMessageData(title: $title, body: $body, subtitle: $subtitle, plate: $plate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationMessageData &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.plate, plate) || other.plate == plate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, body, subtitle, plate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationMessageDataCopyWith<_$_NotificationMessageData>
      get copyWith =>
          __$$_NotificationMessageDataCopyWithImpl<_$_NotificationMessageData>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationMessageDataToJson(
      this,
    );
  }
}

abstract class _NotificationMessageData implements NotificationMessageData {
  const factory _NotificationMessageData(
          {@JsonKey(defaultValue: '') required final String title,
          @JsonKey(defaultValue: '') required final String body,
          @JsonKey(defaultValue: '') required final String subtitle,
          @JsonKey(defaultValue: '') required final String plate}) =
      _$_NotificationMessageData;

  factory _NotificationMessageData.fromJson(Map<String, dynamic> json) =
      _$_NotificationMessageData.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get title;
  @override
  @JsonKey(defaultValue: '')
  String get body;
  @override
  @JsonKey(defaultValue: '')
  String get subtitle;
  @override
  @JsonKey(defaultValue: '')
  String get plate;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationMessageDataCopyWith<_$_NotificationMessageData>
      get copyWith => throw _privateConstructorUsedError;
}
