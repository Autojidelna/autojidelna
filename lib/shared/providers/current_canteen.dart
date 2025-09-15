import 'package:canteenlib/canteenlib.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_canteen.g.dart';

@Riverpod(keepAlive: true)
class CurrentCanteen extends _$CurrentCanteen {
  @override
  Canteen? build() => null;
}
