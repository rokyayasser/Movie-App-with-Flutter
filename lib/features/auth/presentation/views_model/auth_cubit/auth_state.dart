part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

final class AuthSuccess extends AuthState {}

final class AuthPasswordResetSuccess extends AuthState {}

final class AuthSignOutSuccess extends AuthState {}

final class AuthUserLoaded extends AuthState {
  final User user;
  AuthUserLoaded({required this.user});
}

final class AuthPasswordChangeSuccess extends AuthState {}
