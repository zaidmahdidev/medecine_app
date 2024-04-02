import 'package:detection_of_smuggled_medication/shard/bloc_cubit/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/signup_model.dart';
import '../../../network/end_point.dart';
import '../../../network/errors/exceptions.dart';
import '../../../network/remote/dio_helper.dart';



class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  IconData suffix1 = Icons.visibility_outlined;
  bool obscureText1 = true;
  IconData suffix2 = Icons.visibility_outlined;
  bool obscureText2 = true;
  IconData suffix3 = Icons.visibility_outlined;
  bool obscureText3 = true;

  void changePasswordVisibility(String type) {
    if (type == 'field1') {
      obscureText1 = !obscureText1;
      suffix1 = obscureText1
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    } else if (type == 'field2') {
      obscureText2 = !obscureText2;
      suffix2 = obscureText2
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    } else if (type == 'field3') {
      obscureText3 = !obscureText3;
      suffix3 = obscureText3
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    }

    emit(ChangePasswordVisibility());
  }



  SignUpModel? signUpModel;

  void userSignUp({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
  }) async {
    try {
      emit(SignUpLoadingDataState());
      final res = await DioHelper.post(
        url: signup,
        data: {
          'username': username,
          'password': password,
          'confirm_password': confirmPassword,
          'email': email,
        },
      );
      signUpModel = SignUpModel.fromJson(res.data);
      print(signUpModel!.message);
      emit(SignUpSuccessDataState(SignUpModel.fromJson(res.data)));
    } catch (e) {
      if (e is ServerException) {
        emit(SignUpErrorDataState(e.errModel.errorMessage!));
      } else {
        emit(SignUpErrorDataState('حدث خطا غير متوقع!'));
      }
    }
  }
}
