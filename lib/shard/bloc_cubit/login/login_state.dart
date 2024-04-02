import '../../../model/login_in_model.dart';

abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingDataState extends LoginState {}

class LoginSuccessDataState extends LoginState {
  final LoginModel loginModel;
  LoginSuccessDataState(this.loginModel);
}

class LoginErrorDataState extends LoginState {
  final String error;
  LoginErrorDataState(this.error);
}

////////////////////////////////////
class ChangePasswordVisibility extends LoginState {}
