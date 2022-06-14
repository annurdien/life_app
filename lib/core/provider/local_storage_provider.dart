import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';

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
    required String userJson,
  }) = _StorageState;
}

class StorageRepository extends StateNotifier<StorageState> {
  final StateNotifierProviderRef<StorageRepository, StorageState> ref;
  final LazyBox box;

  StorageRepository(this.ref, this.box)
      : super(const StorageState(
          accessToken: "",
          userJson: "",
          idToken: "",
        )) {
    _init();
  }

  void _init() async {
    state = StorageState(
      accessToken: await box.get("accessToken", defaultValue: "") as String,
      idToken: await box.get("idToken", defaultValue: "") as String,
      userJson: await box.get("userJson", defaultValue: "") as String,
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> setAccessToken(String accessToken) async {
    await box.put("accessToken", accessToken);
  }

  Future<void> setUserJson(String userJson) async {
    await box.put("userJson", userJson);
  }

  Future<void> setIdToken(String idToken) async {
    await box.put("idToken", idToken);
  }
}
