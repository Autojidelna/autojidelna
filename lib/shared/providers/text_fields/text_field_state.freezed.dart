// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextFieldState {
  String? get value => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get obscureText => throw _privateConstructorUsedError;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextFieldStateCopyWith<TextFieldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextFieldStateCopyWith<$Res> {
  factory $TextFieldStateCopyWith(
          TextFieldState value, $Res Function(TextFieldState) then) =
      _$TextFieldStateCopyWithImpl<$Res, TextFieldState>;
  @useResult
  $Res call({String? value, String? error, bool obscureText});
}

/// @nodoc
class _$TextFieldStateCopyWithImpl<$Res, $Val extends TextFieldState>
    implements $TextFieldStateCopyWith<$Res> {
  _$TextFieldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? error = freezed,
    Object? obscureText = null,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      obscureText: null == obscureText
          ? _value.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextFieldStateImplCopyWith<$Res>
    implements $TextFieldStateCopyWith<$Res> {
  factory _$$TextFieldStateImplCopyWith(_$TextFieldStateImpl value,
          $Res Function(_$TextFieldStateImpl) then) =
      __$$TextFieldStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value, String? error, bool obscureText});
}

/// @nodoc
class __$$TextFieldStateImplCopyWithImpl<$Res>
    extends _$TextFieldStateCopyWithImpl<$Res, _$TextFieldStateImpl>
    implements _$$TextFieldStateImplCopyWith<$Res> {
  __$$TextFieldStateImplCopyWithImpl(
      _$TextFieldStateImpl _value, $Res Function(_$TextFieldStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? error = freezed,
    Object? obscureText = null,
  }) {
    return _then(_$TextFieldStateImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      obscureText: null == obscureText
          ? _value.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TextFieldStateImpl implements _TextFieldState {
  const _$TextFieldStateImpl({this.value, this.error, this.obscureText = true});

  @override
  final String? value;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool obscureText;

  @override
  String toString() {
    return 'TextFieldState(value: $value, error: $error, obscureText: $obscureText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextFieldStateImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, error, obscureText);

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextFieldStateImplCopyWith<_$TextFieldStateImpl> get copyWith =>
      __$$TextFieldStateImplCopyWithImpl<_$TextFieldStateImpl>(
          this, _$identity);
}

abstract class _TextFieldState implements TextFieldState {
  const factory _TextFieldState(
      {final String? value,
      final String? error,
      final bool obscureText}) = _$TextFieldStateImpl;

  @override
  String? get value;
  @override
  String? get error;
  @override
  bool get obscureText;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextFieldStateImplCopyWith<_$TextFieldStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
