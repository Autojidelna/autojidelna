import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_state.freezed.dart';

@freezed
sealed class TextFieldState with _$TextFieldState {
  const factory TextFieldState({
    String? value,
    String? error,
    @Default(true) bool obscureText,
  }) = _TextFieldState;
}
