import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/models/credential.dart';

final currentUserProvider = StateProvider<UserEntity?>((ref) {
  return null;
});
