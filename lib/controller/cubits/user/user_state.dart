part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLogin extends UserState {
  final User user;
  UserLogin({required this.user});
}

class UserLogout extends UserState {
  final User user;
  UserLogout({required this.user});
}

class UserError extends UserState {
  final String errorMsg;
  UserError({required this.errorMsg});
}
