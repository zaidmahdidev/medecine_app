import 'dart:io';
import 'package:detection_of_smuggled_medication/model/login_in_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/end_point.dart';
import '../../../network/errors/exceptions.dart';
import '../../../network/remote/dio_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility(String type) {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibility());
  }

  LoginModel? loginModel;

  void userLogin({
    required String username,
    required String password,
  }) async {
    try {
      emit(LoginLoadingDataState());
      final res = await DioHelper.post(
        url: login,
        data: {
          'username': username,
          'password': password,
        },
      );
      loginModel = LoginModel.fromJson(res.data);
      print(loginModel!.token);
      emit(LoginSuccessDataState(LoginModel.fromJson(res.data)));
    } catch (e) {
      emit(LoginErrorDataState('اسم المستخدم او كلمة السر غير صحيح'));
    }
  }
}
