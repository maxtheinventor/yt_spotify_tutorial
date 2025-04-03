import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yt_spotify_tutorial/core/providers/current_user_notifier.dart';
import 'package:yt_spotify_tutorial/features/auth/model/user_model.dart';
import 'package:yt_spotify_tutorial/features/auth/repositories/auth_local_repository.dart';
import 'package:yt_spotify_tutorial/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
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
      fp.Right(value: final r) => _loginSuccess(r),
    };
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUserData(token: token);

      final val = switch (res) {
        fp.Left(value: final l) =>
        state = AsyncError(l.message, StackTrace.current),
      fp.Right(value: final r) => _getDataSuccess(r),
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

}
