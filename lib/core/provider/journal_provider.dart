import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/core/provider/local_storage_provider.dart';
import 'package:life_app/models/journal_model.dart';

import 'package:life_app/providers.dart';

import '../../utils.dart';

part 'journal_provider.freezed.dart';

final journalsProvider =
    FutureProvider.autoDispose<List<JournalModel>>((ref) async {
  final client = ref.watch(appQueryProvider);
  final storage = ref.watch(storageProvider);
  final user = storage.userModel;

  final response = await client.getUserJournals(user_id: user!.id!);

  return (response ?? []).map((e) {
    // Convert timestamp from firebase timestamp to DateTime
    Timestamp t = e['created_at'];

    e["created_at"] = t.toDate().toString();

    return JournalModel.fromJson(e);
  }).toList();
});

final journalByIdProvider =
    FutureProvider.autoDispose.family<JournalModel?, String>((ref, id) async {
  final client = ref.watch(appQueryProvider);
  final storage = ref.watch(storageProvider);
  final user = storage.userModel;

  final response = await client.getUserJournalById(
    user_id: user!.id!,
    journal_id: id,
  );

  if (response != null) return JournalModel.fromJson(response);

  return null;
});

final journalControllerProvider =
    StateNotifierProvider<JournalController, JournalState>(
  (ref) => JournalController(ref.read),
);

class JournalController extends StateNotifier<JournalState> {
  JournalController(this.read) : super(JournalState.initial());

  final Reader read;

  Future<void> addJournal(JournalDto journal) async {
    final client = read(appQueryProvider);
    final storage = read(storageProvider);
    final user = storage.userModel;

    state = JournalState.loading();

    try {
      await client.addJournal(
        user_id: user!.id!,
        payload: journal,
      );

      state = JournalState.success();
    } catch (e) {
      logger.e(e);
      JournalState.error(e);
    }
  }
}

@freezed
class JournalState with _$JournalState {
  factory JournalState.initial() = _Initial;
  factory JournalState.loading() = _JournalStateLoading;
  factory JournalState.success() = _JournalStateSuccess;
  factory JournalState.error(Object? error) = _JournalStateError;
}
