import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yt_spotify_tutorial/features/auth/model/user_model.dart';
import 'package:yt_spotify_tutorial/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();

  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    final val = switch (res) {
      fp.Left(value: final l) => l,
      fp.Right(value: final r) => r.name,
    };

    print(val);
  }
}
