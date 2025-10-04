// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canteen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CanteenData implements DiagnosticableTreeMixin {
  /// id, aby se nám neindexovaly špatně jídelníčky
  int get id;

  /// id, aby se nám neindexovaly špatně jídelníčky
  set id(int value);

  /// info o uživateli - např kredit,jméno,příjmení...
  Uzivatel get uzivatel;

  /// info o uživateli - např kredit,jméno,příjmení...
  set uzivatel(Uzivatel value);

  /// seznam jídel, které jsou na burze
  List<Burza> get jidlaNaBurze;

  /// seznam jídel, které jsou na burze
  set jidlaNaBurze(List<Burza> value);

  /// jídelníčky, které aktuálně načítáme
  Map<DateTime, Completer<Jidelnicek>> get currentlyLoading;

  /// jídelníčky, které aktuálně načítáme
  set currentlyLoading(Map<DateTime, Completer<Jidelnicek>> value);

  /// seznam předindexovaných jídelníčků začínající Od Pondělí tohoto týdne
  Map<DateTime, Jidelnicek> get jidelnicky;

  /// seznam předindexovaných jídelníčků začínající Od Pondělí tohoto týdne
  set jidelnicky(Map<DateTime, Jidelnicek> value);

  /// fix pro api vracející méně jídel než by mělo
  Map<DateTime, int> get pocetJidel;

  /// fix pro api vracející méně jídel než by mělo
  set pocetJidel(Map<DateTime, int> value);
  Map<int, String>? get vydejny;
  set vydejny(Map<int, String>? value);

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CanteenDataCopyWith<CanteenData> get copyWith =>
      _$CanteenDataCopyWithImpl<CanteenData>(this as CanteenData, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CanteenData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uzivatel', uzivatel))
      ..add(DiagnosticsProperty('jidlaNaBurze', jidlaNaBurze))
      ..add(DiagnosticsProperty('currentlyLoading', currentlyLoading))
      ..add(DiagnosticsProperty('jidelnicky', jidelnicky))
      ..add(DiagnosticsProperty('pocetJidel', pocetJidel))
      ..add(DiagnosticsProperty('vydejny', vydejny));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CanteenData(id: $id, uzivatel: $uzivatel, jidlaNaBurze: $jidlaNaBurze, currentlyLoading: $currentlyLoading, jidelnicky: $jidelnicky, pocetJidel: $pocetJidel, vydejny: $vydejny)';
  }
}

/// @nodoc
abstract mixin class $CanteenDataCopyWith<$Res> {
  factory $CanteenDataCopyWith(
          CanteenData value, $Res Function(CanteenData) _then) =
      _$CanteenDataCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      Uzivatel uzivatel,
      List<Burza> jidlaNaBurze,
      Map<DateTime, Completer<Jidelnicek>> currentlyLoading,
      Map<DateTime, Jidelnicek> jidelnicky,
      Map<DateTime, int> pocetJidel,
      Map<int, String>? vydejny});

  $UzivatelCopyWith<$Res> get uzivatel;
}

/// @nodoc
class _$CanteenDataCopyWithImpl<$Res> implements $CanteenDataCopyWith<$Res> {
  _$CanteenDataCopyWithImpl(this._self, this._then);

  final CanteenData _self;
  final $Res Function(CanteenData) _then;

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uzivatel = null,
    Object? jidlaNaBurze = null,
    Object? currentlyLoading = null,
    Object? jidelnicky = null,
    Object? pocetJidel = null,
    Object? vydejny = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uzivatel: null == uzivatel
          ? _self.uzivatel
          : uzivatel // ignore: cast_nullable_to_non_nullable
              as Uzivatel,
      jidlaNaBurze: null == jidlaNaBurze
          ? _self.jidlaNaBurze
          : jidlaNaBurze // ignore: cast_nullable_to_non_nullable
              as List<Burza>,
      currentlyLoading: null == currentlyLoading
          ? _self.currentlyLoading
          : currentlyLoading // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Completer<Jidelnicek>>,
      jidelnicky: null == jidelnicky
          ? _self.jidelnicky
          : jidelnicky // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Jidelnicek>,
      pocetJidel: null == pocetJidel
          ? _self.pocetJidel
          : pocetJidel // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
      vydejny: freezed == vydejny
          ? _self.vydejny
          : vydejny // ignore: cast_nullable_to_non_nullable
              as Map<int, String>?,
    ));
  }

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UzivatelCopyWith<$Res> get uzivatel {
    return $UzivatelCopyWith<$Res>(_self.uzivatel, (value) {
      return _then(_self.copyWith(uzivatel: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CanteenData].
extension CanteenDataPatterns on CanteenData {
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
    TResult Function(_CanteenData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CanteenData() when $default != null:
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
    TResult Function(_CanteenData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanteenData():
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
    TResult? Function(_CanteenData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanteenData() when $default != null:
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
            int id,
            Uzivatel uzivatel,
            List<Burza> jidlaNaBurze,
            Map<DateTime, Completer<Jidelnicek>> currentlyLoading,
            Map<DateTime, Jidelnicek> jidelnicky,
            Map<DateTime, int> pocetJidel,
            Map<int, String>? vydejny)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CanteenData() when $default != null:
        return $default(
            _that.id,
            _that.uzivatel,
            _that.jidlaNaBurze,
            _that.currentlyLoading,
            _that.jidelnicky,
            _that.pocetJidel,
            _that.vydejny);
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
            int id,
            Uzivatel uzivatel,
            List<Burza> jidlaNaBurze,
            Map<DateTime, Completer<Jidelnicek>> currentlyLoading,
            Map<DateTime, Jidelnicek> jidelnicky,
            Map<DateTime, int> pocetJidel,
            Map<int, String>? vydejny)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanteenData():
        return $default(
            _that.id,
            _that.uzivatel,
            _that.jidlaNaBurze,
            _that.currentlyLoading,
            _that.jidelnicky,
            _that.pocetJidel,
            _that.vydejny);
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
            int id,
            Uzivatel uzivatel,
            List<Burza> jidlaNaBurze,
            Map<DateTime, Completer<Jidelnicek>> currentlyLoading,
            Map<DateTime, Jidelnicek> jidelnicky,
            Map<DateTime, int> pocetJidel,
            Map<int, String>? vydejny)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CanteenData() when $default != null:
        return $default(
            _that.id,
            _that.uzivatel,
            _that.jidlaNaBurze,
            _that.currentlyLoading,
            _that.jidelnicky,
            _that.pocetJidel,
            _that.vydejny);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CanteenData with DiagnosticableTreeMixin implements CanteenData {
  _CanteenData(
      {this.id = 0,
      required this.uzivatel,
      required this.jidlaNaBurze,
      required this.currentlyLoading,
      required this.jidelnicky,
      required this.pocetJidel,
      this.vydejny});

  /// id, aby se nám neindexovaly špatně jídelníčky
  @override
  @JsonKey()
  int id;

  /// info o uživateli - např kredit,jméno,příjmení...
  @override
  Uzivatel uzivatel;

  /// seznam jídel, které jsou na burze
  @override
  List<Burza> jidlaNaBurze;

  /// jídelníčky, které aktuálně načítáme
  @override
  Map<DateTime, Completer<Jidelnicek>> currentlyLoading;

  /// seznam předindexovaných jídelníčků začínající Od Pondělí tohoto týdne
  @override
  Map<DateTime, Jidelnicek> jidelnicky;

  /// fix pro api vracející méně jídel než by mělo
  @override
  Map<DateTime, int> pocetJidel;
  @override
  Map<int, String>? vydejny;

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CanteenDataCopyWith<_CanteenData> get copyWith =>
      __$CanteenDataCopyWithImpl<_CanteenData>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CanteenData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uzivatel', uzivatel))
      ..add(DiagnosticsProperty('jidlaNaBurze', jidlaNaBurze))
      ..add(DiagnosticsProperty('currentlyLoading', currentlyLoading))
      ..add(DiagnosticsProperty('jidelnicky', jidelnicky))
      ..add(DiagnosticsProperty('pocetJidel', pocetJidel))
      ..add(DiagnosticsProperty('vydejny', vydejny));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CanteenData(id: $id, uzivatel: $uzivatel, jidlaNaBurze: $jidlaNaBurze, currentlyLoading: $currentlyLoading, jidelnicky: $jidelnicky, pocetJidel: $pocetJidel, vydejny: $vydejny)';
  }
}

/// @nodoc
abstract mixin class _$CanteenDataCopyWith<$Res>
    implements $CanteenDataCopyWith<$Res> {
  factory _$CanteenDataCopyWith(
          _CanteenData value, $Res Function(_CanteenData) _then) =
      __$CanteenDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      Uzivatel uzivatel,
      List<Burza> jidlaNaBurze,
      Map<DateTime, Completer<Jidelnicek>> currentlyLoading,
      Map<DateTime, Jidelnicek> jidelnicky,
      Map<DateTime, int> pocetJidel,
      Map<int, String>? vydejny});

  @override
  $UzivatelCopyWith<$Res> get uzivatel;
}

/// @nodoc
class __$CanteenDataCopyWithImpl<$Res> implements _$CanteenDataCopyWith<$Res> {
  __$CanteenDataCopyWithImpl(this._self, this._then);

  final _CanteenData _self;
  final $Res Function(_CanteenData) _then;

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? uzivatel = null,
    Object? jidlaNaBurze = null,
    Object? currentlyLoading = null,
    Object? jidelnicky = null,
    Object? pocetJidel = null,
    Object? vydejny = freezed,
  }) {
    return _then(_CanteenData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uzivatel: null == uzivatel
          ? _self.uzivatel
          : uzivatel // ignore: cast_nullable_to_non_nullable
              as Uzivatel,
      jidlaNaBurze: null == jidlaNaBurze
          ? _self.jidlaNaBurze
          : jidlaNaBurze // ignore: cast_nullable_to_non_nullable
              as List<Burza>,
      currentlyLoading: null == currentlyLoading
          ? _self.currentlyLoading
          : currentlyLoading // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Completer<Jidelnicek>>,
      jidelnicky: null == jidelnicky
          ? _self.jidelnicky
          : jidelnicky // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, Jidelnicek>,
      pocetJidel: null == pocetJidel
          ? _self.pocetJidel
          : pocetJidel // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, int>,
      vydejny: freezed == vydejny
          ? _self.vydejny
          : vydejny // ignore: cast_nullable_to_non_nullable
              as Map<int, String>?,
    ));
  }

  /// Create a copy of CanteenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UzivatelCopyWith<$Res> get uzivatel {
    return $UzivatelCopyWith<$Res>(_self.uzivatel, (value) {
      return _then(_self.copyWith(uzivatel: value));
    });
  }
}

// dart format on
