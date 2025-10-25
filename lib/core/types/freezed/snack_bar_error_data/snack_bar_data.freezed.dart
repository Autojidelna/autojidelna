// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snack_bar_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SnackBarData {
  @JsonKey(name: 'icon_data')
  IconData get iconData;
  @JsonKey(name: 'title')
  String get title;
  @JsonKey(name: 'subtitle')
  String? get subtitle;

  /// Create a copy of SnackBarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnackBarDataCopyWith<SnackBarData> get copyWith =>
      _$SnackBarDataCopyWithImpl<SnackBarData>(
          this as SnackBarData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnackBarData &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, iconData, title, subtitle);

  @override
  String toString() {
    return 'SnackBarData(iconData: $iconData, title: $title, subtitle: $subtitle)';
  }
}

/// @nodoc
abstract mixin class $SnackBarDataCopyWith<$Res> {
  factory $SnackBarDataCopyWith(
          SnackBarData value, $Res Function(SnackBarData) _then) =
      _$SnackBarDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'icon_data') IconData iconData,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'subtitle') String? subtitle});
}

/// @nodoc
class _$SnackBarDataCopyWithImpl<$Res> implements $SnackBarDataCopyWith<$Res> {
  _$SnackBarDataCopyWithImpl(this._self, this._then);

  final SnackBarData _self;
  final $Res Function(SnackBarData) _then;

  /// Create a copy of SnackBarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iconData = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_self.copyWith(
      iconData: null == iconData
          ? _self.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SnackBarData].
extension SnackBarDataPatterns on SnackBarData {
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
    TResult Function(_SnackBarData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SnackBarData() when $default != null:
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
    TResult Function(_SnackBarData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SnackBarData():
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
    TResult? Function(_SnackBarData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SnackBarData() when $default != null:
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
    TResult Function(
            @JsonKey(name: 'icon_data') IconData iconData,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'subtitle') String? subtitle)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SnackBarData() when $default != null:
        return $default(_that.iconData, _that.title, _that.subtitle);
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
    TResult Function(
            @JsonKey(name: 'icon_data') IconData iconData,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'subtitle') String? subtitle)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SnackBarData():
        return $default(_that.iconData, _that.title, _that.subtitle);
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
    TResult? Function(
            @JsonKey(name: 'icon_data') IconData iconData,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'subtitle') String? subtitle)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SnackBarData() when $default != null:
        return $default(_that.iconData, _that.title, _that.subtitle);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SnackBarData implements SnackBarData {
  const _SnackBarData(
      {@JsonKey(name: 'icon_data') required this.iconData,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'subtitle') this.subtitle});

  @override
  @JsonKey(name: 'icon_data')
  final IconData iconData;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'subtitle')
  final String? subtitle;

  /// Create a copy of SnackBarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnackBarDataCopyWith<_SnackBarData> get copyWith =>
      __$SnackBarDataCopyWithImpl<_SnackBarData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnackBarData &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, iconData, title, subtitle);

  @override
  String toString() {
    return 'SnackBarData(iconData: $iconData, title: $title, subtitle: $subtitle)';
  }
}

/// @nodoc
abstract mixin class _$SnackBarDataCopyWith<$Res>
    implements $SnackBarDataCopyWith<$Res> {
  factory _$SnackBarDataCopyWith(
          _SnackBarData value, $Res Function(_SnackBarData) _then) =
      __$SnackBarDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'icon_data') IconData iconData,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'subtitle') String? subtitle});
}

/// @nodoc
class __$SnackBarDataCopyWithImpl<$Res>
    implements _$SnackBarDataCopyWith<$Res> {
  __$SnackBarDataCopyWithImpl(this._self, this._then);

  final _SnackBarData _self;
  final $Res Function(_SnackBarData) _then;

  /// Create a copy of SnackBarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? iconData = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_SnackBarData(
      iconData: null == iconData
          ? _self.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
