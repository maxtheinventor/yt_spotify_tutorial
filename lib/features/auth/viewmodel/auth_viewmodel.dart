import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yt_spotify_tutorial/features/auth/model/user_model.dart';
import 'package:yt_spotify_tutorial/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository =ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    final val = switch (res) {
      fp.Left(value: final l) =>
        state = AsyncError(l.message, StackTrace.current),
      fp.Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );
    final val = switch (res) {
      fp.Left(value: final l) =>
        state = AsyncError(l.message, StackTrace.current),
      fp.Right(value: final r) => state = AsyncValue.data(r),
    };
  }
}
