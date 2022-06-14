// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:life_app/constants.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../utils.dart';
// import 'models/user_model.dart';
// import 'query.dart';

// part 'supabase.freezed.dart';

// class SupabaseQuery implements Query {
//   SupabaseQuery(this.read);

//   final Reader read;
//   final supabase = SupabaseClient(
//     Constants.SUPABASE_URL,
//     Constants.SUPABASE_ANON_KEY,
//   );

//   @override
//   Future<Map<String, dynamic>?> getMusics() async {
//     final response = await supabase.from("relief").select("*").execute();

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }

//     return response.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> getUser({required String id}) async {
//     final response = await supabase
//         .from("app_user")
//         .select()
//         .eq('user_id', id)
//         .single()
//         .execute();

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }

//     return response.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> getUserJournalById({
//     required String journal_id,
//   }) async {
//     final response = await supabase
//         .from("user_journal")
//         .select()
//         .eq("journal_id", journal_id)
//         .single()
//         .execute();

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }
//     return response.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> getUserJournals(
//       {required String user_id}) async {
//     final response = await supabase
//         .from("user_journal")
//         .select()
//         .eq("user_id", user_id)
//         .execute();

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }
//     return response.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> sigIn({
//     required String email,
//     required String password,
//   }) async {
//     final response =
//         await supabase.auth.signIn(email: email, password: password);

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }

//     return response.data!.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> signUp({
//     required String fullname,
//     required String email,
//     required String phone,
//     required String password,
//   }) async {
//     final response = await supabase.auth.signUp(email, password);

//     if (response.error != null) {
//       logger.e(response.error!.message);
//       return null;
//     }

//     final user = response.data!.user!;

//     return await _createUser(user, name: fullname, phone: phone);
//   }

//   @override
//   Future<Map<String, dynamic>?> updateUser(Object payload) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Map<String, dynamic>?> updateUserJournal(Object payload) {
//     throw UnimplementedError();
//   }

//   Future<Map<String, dynamic>?> _createUser(
//     User user, {
//     required String name,
//     required String phone,
//   }) async {
//     final response = await supabase
//         .from("app_users")
//         .insert(
//           UserModel(
//             user_id: user.id,
//             full_name: name,
//             email: user.email,
//             phone: phone,
//           ),
//         )
//         .execute();

//     return response.toJson();
//   }

//   @override
//   Future<Map<String, dynamic>?> createJournal({
//     required String user_id,
//     required String title,
//     required String body,
//     required int feeling,
//     required int emotion,
//   }) async {
//     final response = await supabase
//         .from("user_journal")
//         .insert(
//           UserJournalModel(
//             user_id: user_id,
//             title: title,
//             body: body,
//             feeling: feeling,
//             emotion: emotion,
//           ),
//         )
//         .execute();

//     if (response.error != null) {
//       logger.e(response.error);
//       return null;
//     }

//     return response.toJson();
//   }
  
//   @override
//   Future<Map<String, dynamic>?> sigInWithEmailAndPassword({required String email, required String password}) {
//     // TODO: implement sigInWithEmailAndPassword
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Map<String, dynamic>?> signInWithGoogle() {
//     // TODO: implement signInWithGoogle
//     throw UnimplementedError();
//   }
// }

// @freezed
// class AuthDto extends Object with _$AuthDto {
//   const factory AuthDto({
//     required String email,
//     required String password,
//     String? name,
//   }) = _AuthDto;

//   factory AuthDto.fromJson(Map<String, dynamic> json) =>
//       _$AuthDtoFromJson(json);
// }

// @freezed
// class UserJournalModel with _$UserJournalModel {
//   const factory UserJournalModel({
//     required String user_id,
//     required String title,
//     required String body,
//     required int feeling,
//     required int emotion,
//   }) = _UserJournalModel;

//   factory UserJournalModel.fromJson(Map<String, dynamic> json) =>
//       _$UserJournalModelFromJson(json);
// }
