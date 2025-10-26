// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_accounts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoggedAccounts implements DiagnosticableTreeMixin {

@JsonKey(name: 'logged_in_account') SafeAccount? get loggedInAccount;@JsonKey(name: 'logged_in_account') set loggedInAccount(SafeAccount? value);@JsonKey(name: 'accounts') List<Account> get accounts;@JsonKey(name: 'accounts') set accounts(List<Account> value);
/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoggedAccountsCopyWith<LoggedAccounts> get copyWith => _$LoggedAccountsCopyWithImpl<LoggedAccounts>(this as LoggedAccounts, _$identity);

  /// Serializes this LoggedAccounts to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoggedAccounts'))
    ..add(DiagnosticsProperty('loggedInAccount', loggedInAccount))..add(DiagnosticsProperty('accounts', accounts));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoggedAccounts(loggedInAccount: $loggedInAccount, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $LoggedAccountsCopyWith<$Res>  {
  factory $LoggedAccountsCopyWith(LoggedAccounts value, $Res Function(LoggedAccounts) _then) = _$LoggedAccountsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'logged_in_account') SafeAccount? loggedInAccount,@JsonKey(name: 'accounts') List<Account> accounts
});


$SafeAccountCopyWith<$Res>? get loggedInAccount;

}
/// @nodoc
class _$LoggedAccountsCopyWithImpl<$Res>
    implements $LoggedAccountsCopyWith<$Res> {
  _$LoggedAccountsCopyWithImpl(this._self, this._then);

  final LoggedAccounts _self;
  final $Res Function(LoggedAccounts) _then;

/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loggedInAccount = freezed,Object? accounts = null,}) {
  return _then(_self.copyWith(
loggedInAccount: freezed == loggedInAccount ? _self.loggedInAccount : loggedInAccount // ignore: cast_nullable_to_non_nullable
as SafeAccount?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,
  ));
}
/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SafeAccountCopyWith<$Res>? get loggedInAccount {
    if (_self.loggedInAccount == null) {
    return null;
  }

  return $SafeAccountCopyWith<$Res>(_self.loggedInAccount!, (value) {
    return _then(_self.copyWith(loggedInAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoggedAccounts].
extension LoggedAccountsPatterns on LoggedAccounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoggedAccounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoggedAccounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoggedAccounts value)  $default,){
final _that = this;
switch (_that) {
case _LoggedAccounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoggedAccounts value)?  $default,){
final _that = this;
switch (_that) {
case _LoggedAccounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'logged_in_account')  SafeAccount? loggedInAccount, @JsonKey(name: 'accounts')  List<Account> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoggedAccounts() when $default != null:
return $default(_that.loggedInAccount,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'logged_in_account')  SafeAccount? loggedInAccount, @JsonKey(name: 'accounts')  List<Account> accounts)  $default,) {final _that = this;
switch (_that) {
case _LoggedAccounts():
return $default(_that.loggedInAccount,_that.accounts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'logged_in_account')  SafeAccount? loggedInAccount, @JsonKey(name: 'accounts')  List<Account> accounts)?  $default,) {final _that = this;
switch (_that) {
case _LoggedAccounts() when $default != null:
return $default(_that.loggedInAccount,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoggedAccounts with DiagnosticableTreeMixin implements LoggedAccounts {
   _LoggedAccounts({@JsonKey(name: 'logged_in_account') this.loggedInAccount, @JsonKey(name: 'accounts') this.accounts = const []});
  factory _LoggedAccounts.fromJson(Map<String, dynamic> json) => _$LoggedAccountsFromJson(json);

@override@JsonKey(name: 'logged_in_account')  SafeAccount? loggedInAccount;
@override@JsonKey(name: 'accounts')  List<Account> accounts;

/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoggedAccountsCopyWith<_LoggedAccounts> get copyWith => __$LoggedAccountsCopyWithImpl<_LoggedAccounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoggedAccountsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoggedAccounts'))
    ..add(DiagnosticsProperty('loggedInAccount', loggedInAccount))..add(DiagnosticsProperty('accounts', accounts));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoggedAccounts(loggedInAccount: $loggedInAccount, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$LoggedAccountsCopyWith<$Res> implements $LoggedAccountsCopyWith<$Res> {
  factory _$LoggedAccountsCopyWith(_LoggedAccounts value, $Res Function(_LoggedAccounts) _then) = __$LoggedAccountsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'logged_in_account') SafeAccount? loggedInAccount,@JsonKey(name: 'accounts') List<Account> accounts
});


@override $SafeAccountCopyWith<$Res>? get loggedInAccount;

}
/// @nodoc
class __$LoggedAccountsCopyWithImpl<$Res>
    implements _$LoggedAccountsCopyWith<$Res> {
  __$LoggedAccountsCopyWithImpl(this._self, this._then);

  final _LoggedAccounts _self;
  final $Res Function(_LoggedAccounts) _then;

/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loggedInAccount = freezed,Object? accounts = null,}) {
  return _then(_LoggedAccounts(
loggedInAccount: freezed == loggedInAccount ? _self.loggedInAccount : loggedInAccount // ignore: cast_nullable_to_non_nullable
as SafeAccount?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<Account>,
  ));
}

/// Create a copy of LoggedAccounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SafeAccountCopyWith<$Res>? get loggedInAccount {
    if (_self.loggedInAccount == null) {
    return null;
  }

  return $SafeAccountCopyWith<$Res>(_self.loggedInAccount!, (value) {
    return _then(_self.copyWith(loggedInAccount: value));
  });
}
}

// dart format on
