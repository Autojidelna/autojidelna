// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safe_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SafeAccount implements DiagnosticableTreeMixin {

@JsonKey(name: 'username') String get username;@JsonKey(name: 'url') String get url;
/// Create a copy of SafeAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafeAccountCopyWith<SafeAccount> get copyWith => _$SafeAccountCopyWithImpl<SafeAccount>(this as SafeAccount, _$identity);

  /// Serializes this SafeAccount to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SafeAccount'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('url', url));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafeAccount&&(identical(other.username, username) || other.username == username)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,url);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SafeAccount(username: $username, url: $url)';
}


}

/// @nodoc
abstract mixin class $SafeAccountCopyWith<$Res>  {
  factory $SafeAccountCopyWith(SafeAccount value, $Res Function(SafeAccount) _then) = _$SafeAccountCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'username') String username,@JsonKey(name: 'url') String url
});




}
/// @nodoc
class _$SafeAccountCopyWithImpl<$Res>
    implements $SafeAccountCopyWith<$Res> {
  _$SafeAccountCopyWithImpl(this._self, this._then);

  final SafeAccount _self;
  final $Res Function(SafeAccount) _then;

/// Create a copy of SafeAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? url = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SafeAccount].
extension SafeAccountPatterns on SafeAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafeAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafeAccount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafeAccount value)  $default,){
final _that = this;
switch (_that) {
case _SafeAccount():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafeAccount value)?  $default,){
final _that = this;
switch (_that) {
case _SafeAccount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'username')  String username, @JsonKey(name: 'url')  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafeAccount() when $default != null:
return $default(_that.username,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'username')  String username, @JsonKey(name: 'url')  String url)  $default,) {final _that = this;
switch (_that) {
case _SafeAccount():
return $default(_that.username,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'username')  String username, @JsonKey(name: 'url')  String url)?  $default,) {final _that = this;
switch (_that) {
case _SafeAccount() when $default != null:
return $default(_that.username,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafeAccount extends SafeAccount with DiagnosticableTreeMixin {
  const _SafeAccount({@JsonKey(name: 'username') required this.username, @JsonKey(name: 'url') required this.url}): super._();
  factory _SafeAccount.fromJson(Map<String, dynamic> json) => _$SafeAccountFromJson(json);

@override@JsonKey(name: 'username') final  String username;
@override@JsonKey(name: 'url') final  String url;

/// Create a copy of SafeAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafeAccountCopyWith<_SafeAccount> get copyWith => __$SafeAccountCopyWithImpl<_SafeAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafeAccountToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SafeAccount'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('url', url));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafeAccount&&(identical(other.username, username) || other.username == username)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,url);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SafeAccount(username: $username, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SafeAccountCopyWith<$Res> implements $SafeAccountCopyWith<$Res> {
  factory _$SafeAccountCopyWith(_SafeAccount value, $Res Function(_SafeAccount) _then) = __$SafeAccountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'username') String username,@JsonKey(name: 'url') String url
});




}
/// @nodoc
class __$SafeAccountCopyWithImpl<$Res>
    implements _$SafeAccountCopyWith<$Res> {
  __$SafeAccountCopyWithImpl(this._self, this._then);

  final _SafeAccount _self;
  final $Res Function(_SafeAccount) _then;

/// Create a copy of SafeAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? url = null,}) {
  return _then(_SafeAccount(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
