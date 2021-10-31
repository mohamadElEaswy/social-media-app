import 'package:untitled/core/models/user_model.dart';

abstract class AuthState{}

class LoginInitState extends AuthState{}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  final String? userName;

  LoginSuccessState({required this.userName});
}
class LoginErrorState extends AuthState{
  final String error;

  LoginErrorState({required this.error});
}


class LoadingRegisterState extends AuthState{}
class SuccessRegisterState extends AuthState{}
class ErrorRegisterState extends AuthState{
  final String error;

  ErrorRegisterState({required this.error});
}
class LoadingCreateUser extends AuthState{}
class SuccessCreateUser extends AuthState{
  final UserModel userModel;

  SuccessCreateUser({required this.userModel});
}
class ErrorCreateUser extends AuthState{
  final String error;

  ErrorCreateUser({required this.error});
}
class ChangePasswordVisibility extends AuthState{}


class GetUserSuccessState extends AuthState{
 final UserModel model;

  GetUserSuccessState({required this.model});
}
class GetUserLoadingState extends AuthState{}
class GetUserErrorState extends AuthState{
  final String error;

  GetUserErrorState({required this.error});
}


class ChangeBottomNav extends AuthState{}
class SocialNewPostState extends AuthState{}