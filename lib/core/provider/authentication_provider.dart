import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/user_model.dart';
import '../../providers.dart';
import '../../utils.dart';
import 'local_storage_provider.dart';

part 'authentication_provider.freezed.dart';

final authenticationProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>((ref) {
  return AuthenticationController(ref.read);
});

class AuthenticationController extends StateNotifier<AuthenticationState> {
  final Reader read;

  AuthenticationController(
    this.read,
  ) : super(const AuthenticationState.uninitialized()) {
    _init();
    stream.listen(_streamListener);
  }

  _streamListener(AuthenticationState event) {
    event.whenOrNull(
      authenticated: (user) async {
        final userModel = UserModel.fromJson(user.toJson());
        await read(storageProvider.notifier).putUserModel(userModel);
      },
    );
  }

  Future<UserModel?> getUser(String user_id) async {
    final client = read(appQueryProvider);
    try {
      final response = await client.getUser(user_id: user_id);
      if (response != null) {
        return UserModel.fromJson(response).copyWith(id: user_id);
      }
      return null;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> _init() async {
    final storage = read(storageProvider.notifier);

    await storage.init();

    final accessToken = storage.state.accessToken;

    if (accessToken.isNotEmpty) {
      try {
        final credential = GoogleAuthProvider.credential(
          accessToken: accessToken,
        );

        final response =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Get User
        final user = await getUser(response.user!.uid);

        if (user != null) {
          state = AuthenticationState.authenticated(user);
        } else {
          state = const AuthenticationState.unauthenticated();
        }
      } catch (e) {
        logger.e("AuthenticationController", e, StackTrace.current);
        // TODO: Handle timeout or other error
        state = const AuthenticationState.unauthenticated();
      }
    } else {
      state = const AuthenticationState.unauthenticated();
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    final storage = read(storageProvider.notifier);
    await storage.setAccessToken("");
    await storage.putUserModel(null);
    await storage.setIdToken("");
    await FirebaseAuth.instance.signOut();
    state = const AuthenticationState.unauthenticated();
  }

  Future<void> loginWithGoogle() async {
    final client = read(appQueryProvider);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken == null) {
        throw Exception("Google sign in canceled");
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credentials = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      String? token = googleAuth?.accessToken;
      String? idToken = googleAuth?.idToken;
      String? uid = credentials.user?.uid;

      if (token == null || uid == null) {
        throw NoUIDException();
      }

      final storage = read(storageProvider.notifier);

      await storage.setAccessToken(token);
      await storage.setIdToken(idToken ?? "");

      final user = await getUser(uid);

      if (user == null) {
        final user = UserDto(
          email: credentials.user?.email,
          image: credentials.user?.photoURL!,
          name: credentials.user?.displayName!,
          phone: credentials.user?.phoneNumber,
        );

        await client.signUp(
          user_id: uid,
          payload: user,
        );

        logger.wtf(user.toJson());

        state = AuthenticationState.authenticated(
          UserModel.fromJson(user.toJson()).copyWith(id: uid),
        );

        return;
      }

      await storage.putUserModel(user);

      state = AuthenticationState.authenticated(user.copyWith(id: uid));
    } on FirebaseException catch (e, stacktrace) {
      logger.e("AuthenticationController", e, stacktrace);
    } catch (e, stacktrace) {
      logger.e("AuthenticationController", e, stacktrace);
      rethrow;
    }
  }

  Future<void> signupWithEmailPassword(
    String email,
    String password,
    String passwordConfirmation,
    String fullname,
    String phone,
  ) async {
    try {
      final storage = read(storageProvider.notifier);
      final client = read(appQueryProvider);

      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserDto(
        email: email,
        name: fullname,
        phone: phone,
        image: null,
      );

      await client.signUp(
        user_id: response.user!.uid,
        payload: user,
      );

      state = AuthenticationState.authenticated(
        UserModel.fromJson(user.toJson()),
      );

      await storage.putUserModel(UserModel.fromJson(user.toJson()));

      return;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.uninitialized() =
      AuthenticationStateUninitialized;
  const factory AuthenticationState.unauthenticated() =
      AuthenticationStateUnauthenticated;
  const factory AuthenticationState.authenticated(UserModel user) =
      AuthenticationStateAuthorized;
  const factory AuthenticationState.error(String reason) =
      AuthenticationStateError;
}

class NoUIDException implements Exception {
  final String message;
  NoUIDException({this.message = "No UID"});
}
