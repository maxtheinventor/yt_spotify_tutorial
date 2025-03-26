import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yt_spotify_tutorial/features/auth/model/user_model.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }
}
