import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/core/provider/local_storage_provider.dart';

import '../../models/user_model.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final hive = ref.watch(hiveProvider);

  final UserModel user = await hive.get("userModel");

  return user;
});
