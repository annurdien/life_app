import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/models/user_model.dart';

import '../../constants.dart';
import '../../utils.dart';

part 'local_storage_provider.freezed.dart';

final hiveProvider = Provider((ref) {
  final hive = Hive.lazyBox(Constants.BOX_NAME);

  return hive;
});

final storageProvider =
    StateNotifierProvider<StorageRepository, StorageState>((ref) {
  final storage = ref.watch(hiveProvider);

  return StorageRepository(ref, storage);
});

@freezed
class StorageState with _$StorageState {
  const factory StorageState({
    required String accessToken,
    required String idToken,
    required UserModel? userModel,
  }) = _StorageState;
}

class StorageRepository extends StateNotifier<StorageState> {
  final StateNotifierProviderRef<StorageRepository, StorageState> ref;
  final LazyBox box;

  StorageRepository(this.ref, this.box)
      : super(const StorageState(
          accessToken: "",
          userModel: null,
          idToken: "",
        ));

  Future<void> init() async {
    final accessToken = await box.get("accessToken", defaultValue: "");
    final idToken = await box.get("idToken", defaultValue: "");
    final userJson = await box.get("userModel");

    state = StorageState(
      accessToken: accessToken,
      idToken: idToken,
      userModel: userJson,
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> setAccessToken(String accessToken) async {
    await box.put("accessToken", accessToken);
  }

  Future<void> putUserModel(UserModel? user) async {
    await box.put("userModel", user);
  }

  Future<void> setIdToken(String idToken) async {
    await box.put("idToken", idToken);
  }
}
