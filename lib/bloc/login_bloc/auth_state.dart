part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState{}

class AuthFailed extends AuthState{}

class AuthLoading extends AuthState{}

class AuthOffline extends AuthState{}
