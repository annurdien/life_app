import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_app/core/query.dart';
import 'package:life_app/models/user_model.dart';
import 'package:life_app/models/journal_model.dart';

class FirebaseQuery implements AppQuery {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>?> createJournal({
    required String user_id,
    required JournalDto payload,
  }) async {
    final response = await _firestore
        .collection("users")
        .doc(user_id)
        .collection("user_journal")
        .add(payload.toJson());

    return response.snapshots().map((snapshot) => snapshot.data()).first;
  }

  @override
  Future<List<Map<String, dynamic>>?> getMusics() async {
    final response = await _firestore.collection("relief").get();

    return response.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Map<String, dynamic>?> getUser({
    required String user_id,
  }) async {
    final response = await _firestore.collection("users").doc(user_id).get();

    return response.data();
  }

  @override
  Future<Map<String, dynamic>?> getUserJournalById({
    required String user_id,
    required String journal_id,
  }) async {
    final response = await _firestore
        .collection("users")
        .doc(user_id)
        .collection("user_journal")
        .doc(journal_id)
        .get();

    return response.data();
  }

  @override
  Future<List<Map<String, dynamic>>?> getUserJournals({
    required String user_id,
  }) async {
    final response = await _firestore
        .collection("users")
        .doc(user_id)
        .collection("user_journal")
        .get();

    return response.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> updateUser({
    required String user_id,
    required UserDto payload,
  }) async {
    await _firestore.collection("users").doc(user_id).update(payload.toJson());
  }

  @override
  Future<void> updateUserJournal({
    required String user_id,
    required String journal_id,
    required JournalDto payload,
  }) async {
    await _firestore
        .collection("users")
        .doc(user_id)
        .collection("user_journal")
        .doc(journal_id)
        .update(payload.toJson());
  }

  @override
  Future<void> signUp({
    required String user_id,
    required UserDto payload,
  }) async {
    await _firestore.collection("users").doc(user_id).set(payload.toJson());
  }
}
