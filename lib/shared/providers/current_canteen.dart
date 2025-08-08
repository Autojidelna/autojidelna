import 'package:canteenlib/canteenlib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentCanteen = StateProvider<Canteen>((ref) => Canteen('url'));
