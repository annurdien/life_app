import 'package:life_app/models/journal_model.dart';

import '../models/user_model.dart';

abstract class AppQuery {
  Future<void> signUp({
    required String user_id,
    required UserDto payload,
  });

  Future<Map<String, dynamic>?> getUser({
    required String user_id,
  });

  Future<List<Map<String, dynamic>>?> getUserJournals({
    required String user_id,
  });

  Future<Map<String, dynamic>?> getUserJournalById({
    required String user_id,
    required String journal_id,
  });

  Future<Map<String, dynamic>?> createJournal({
    required String user_id,
    required JournalDto payload,
  });

  Future<void> updateUserJournal({
    required String user_id,
    required String journal_id,
    required JournalDto payload,
  });

  Future<void> updateUser({
    required String user_id,
    required UserDto payload,
  });

  Future<List<Map<String, dynamic>>?> getMusics();
}
