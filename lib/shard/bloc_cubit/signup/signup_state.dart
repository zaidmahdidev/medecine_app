import 'package:detection_of_smuggled_medication/model/login_in_model.dart';
import 'package:detection_of_smuggled_medication/model/signup_model.dart';

abstract class SignUpState {}

class SignUpInitState extends SignUpState {}

class SignUpLoadingDataState extends SignUpState {}

class SignUpSuccessDataState extends SignUpState {
  final SignUpModel signUpModel;
  SignUpSuccessDataState(this.signUpModel);
}

class SignUpErrorDataState extends SignUpState {
  final String error;
  SignUpErrorDataState(this.error);
}

////////////////////////////////////
class ChangePasswordVisibility extends SignUpState {}
