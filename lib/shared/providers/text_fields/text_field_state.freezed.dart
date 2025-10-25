// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextFieldState {
  String? get value;
  String? get error;
  bool get obscureText;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextFieldStateCopyWith<TextFieldState> get copyWith =>
      _$TextFieldStateCopyWithImpl<TextFieldState>(
          this as TextFieldState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextFieldState &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, error, obscureText);

  @override
  String toString() {
    return 'TextFieldState(value: $value, error: $error, obscureText: $obscureText)';
  }
}

/// @nodoc
abstract mixin class $TextFieldStateCopyWith<$Res> {
  factory $TextFieldStateCopyWith(
          TextFieldState value, $Res Function(TextFieldState) _then) =
      _$TextFieldStateCopyWithImpl;
  @useResult
  $Res call({String? value, String? error, bool obscureText});
}

/// @nodoc
class _$TextFieldStateCopyWithImpl<$Res>
    implements $TextFieldStateCopyWith<$Res> {
  _$TextFieldStateCopyWithImpl(this._self, this._then);

  final TextFieldState _self;
  final $Res Function(TextFieldState) _then;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? error = freezed,
    Object? obscureText = null,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      obscureText: null == obscureText
          ? _self.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [TextFieldState].
extension TextFieldStatePatterns on TextFieldState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TextFieldState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextFieldState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TextFieldState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TextFieldState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? value, String? error, bool obscureText)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TextFieldState() when $default != null:
        return $default(_that.value, _that.error, _that.obscureText);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? value, String? error, bool obscureText) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldState():
        return $default(_that.value, _that.error, _that.obscureText);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? value, String? error, bool obscureText)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TextFieldState() when $default != null:
        return $default(_that.value, _that.error, _that.obscureText);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TextFieldState implements TextFieldState {
  const _TextFieldState({this.value, this.error, this.obscureText = true});

  @override
  final String? value;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool obscureText;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextFieldStateCopyWith<_TextFieldState> get copyWith =>
      __$TextFieldStateCopyWithImpl<_TextFieldState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextFieldState &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.obscureText, obscureText) ||
                other.obscureText == obscureText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, error, obscureText);

  @override
  String toString() {
    return 'TextFieldState(value: $value, error: $error, obscureText: $obscureText)';
  }
}

/// @nodoc
abstract mixin class _$TextFieldStateCopyWith<$Res>
    implements $TextFieldStateCopyWith<$Res> {
  factory _$TextFieldStateCopyWith(
          _TextFieldState value, $Res Function(_TextFieldState) _then) =
      __$TextFieldStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? value, String? error, bool obscureText});
}

/// @nodoc
class __$TextFieldStateCopyWithImpl<$Res>
    implements _$TextFieldStateCopyWith<$Res> {
  __$TextFieldStateCopyWithImpl(this._self, this._then);

  final _TextFieldState _self;
  final $Res Function(_TextFieldState) _then;

  /// Create a copy of TextFieldState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? error = freezed,
    Object? obscureText = null,
  }) {
    return _then(_TextFieldState(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      obscureText: null == obscureText
          ? _self.obscureText
          : obscureText // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
