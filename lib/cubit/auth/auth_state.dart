part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

final class ListAuthSuccess extends AuthState {
  final List<UserModel> users;

  const ListAuthSuccess({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}

final class AuthFailed extends AuthState {
  final String error;

  const AuthFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
