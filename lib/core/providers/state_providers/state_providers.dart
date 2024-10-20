import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncPage = StateProvider((ref) => 1);
final isSyncingProvider = StateProvider((ref) => false);