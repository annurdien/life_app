import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/core/provider/local_storage_provider.dart';
import 'package:life_app/models/journal_model.dart';
import 'package:life_app/models/user_model.dart';
import 'package:life_app/providers.dart';

final journalsProvider =
    FutureProvider.autoDispose<List<JournalModel>>((ref) async {
  final client = ref.watch(appQueryProvider);
  final storage = ref.watch(storageProvider);
  final user = UserModel.fromJson(json.decode(storage.userJson));

  final response = await client.getUserJournals(user_id: user.id!);

  return (response ?? []).map((e) => JournalModel.fromJson(e)).toList();
});

final journalByIdProvider =
    FutureProvider.autoDispose.family<JournalModel?, String>((ref, id) async {
  final client = ref.watch(appQueryProvider);
  final storage = ref.watch(storageProvider);
  final user = UserModel.fromJson(json.decode(storage.userJson));

  final response =
      await client.getUserJournalById(user_id: user.id!, journal_id: id);

  if (response != null) return JournalModel.fromJson(response);

  return null;
});
