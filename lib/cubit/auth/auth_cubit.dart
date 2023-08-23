import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';
import '../../service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Sign in with email and password from Firebase Authentication
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Set AuthLoading
      emit(AuthLoading());

      // Sign in with email and password from Firebase Authentication
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );

      // Set AuthSuccess
      emit(AuthSuccess(user: user));
    } catch (e) {
      // Set AuthFailed
      emit(AuthFailed(error: e.toString()));
    }
  }

  // Sign out from Firebase Authentication
  Future<void> signOut() async {
    try {
      // Set AuthLoading
      emit(AuthLoading());

      // Sign out from Firebase Authentication
      await AuthService().signOut();

      // Set AuthInitial
      emit(AuthInitial());
    } catch (e) {
      // Set AuthFailed
      emit(AuthFailed(error: e.toString()));
    }
  }
}
