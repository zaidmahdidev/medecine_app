import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:detection_of_smuggled_medication/screen/home_screen/home_screen.dart';
import 'package:detection_of_smuggled_medication/screen/sign_up/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../network/local/cache_helper.dart';
import '../../shard/bloc_cubit/internet/inernet_cubit.dart';
import '../../shard/bloc_cubit/internet/internet_state.dart';
import '../../shard/bloc_cubit/login/login_cubit.dart';
import '../../shard/bloc_cubit/login/login_state.dart';
import '../../shard/components/tools.dart';
import '../../shard/constant/images.dart';
import '../../shard/constant/theme.dart';
import '../../shard/constant/validinput.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var useNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessDataState) {
          ToastManager.showToast(
              ' تم  تسجيل الدخول بنجاح', ToastStates.SUCCESS);
          CacheHelper.saveData(key: 'login', value: true).then((value) => print('hi'));
          CacheHelper.saveData(key: 'token', value: state.loginModel.token)
              .then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BlocBuilder<InternetCubit, InternetState>(
                          builder: (context, state) => HomeScreen()),
                ),
                (route) => false);
            token = CacheHelper.getData(key: 'token');
            // HomeCubit.get(context).getData();
          });
        }

        if (state is LoginErrorDataState) {
          ToastManager.showToast(state.error, ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SafeArea(
                child: Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
              body: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    decoration:  BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Lottie.asset(
                              'assets/image/Animation - 1711599235861.json',
                              fit: BoxFit.fill),
                        ),
                        Container(
                          decoration:  BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('تسجيل الدخول',
                                    style: MyTheme.textStyle24),
                                const SizedBox(height: 40),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      CustomTextFormAuth(
                                        hinttext: 'ادخل اسم المستخدم',
                                        isNumber: false,
                                        borderRadius: 10,
                                        labeltext: 'اسم المستخدم',
                                        mycontroller: useNameController,
                                        obscureText: false,
                                        prefixIcon: Icons.person,
                                        valid: (val) {
                                          return validInput(
                                              val!, 3, 15, "password");
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      CustomTextFormAuth(
                                        hinttext: 'ادخل كـلمة السر',
                                        isNumber: false,
                                        labeltext: 'كلمة السر',
                                        borderRadius: 10,
                                        mycontroller: passwordController,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText:
                                            LoginCubit.get(context).obscureText,
                                        iconData:
                                            LoginCubit.get(context).suffix,
                                        onTapIcon: () {
                                          LoginCubit.get(context)
                                              .changePasswordVisibility(
                                                  'field1');
                                        },
                                        valid: (val) {
                                          return validInput(
                                              val!, 0, 20, "password");
                                        },
                                      ),
                                      const SizedBox(height: 40),
                                      ConditionalBuilder(
                                        condition:
                                            state is! LoginLoadingDataState,
                                        builder: (context) => defaultButton(
                                          fun: () {
                                            // Navigator.pushAndRemoveUntil(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           BlocBuilder<InternetCubit,
                                            //                   InternetState>(
                                            //               builder: (context,
                                            //                       state) =>
                                            //                   HomeScreen()),
                                            //     ),
                                            //     (route) => false);
                                            if (formKey.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userLogin(
                                                  username:
                                                      useNameController.text,
                                                  password:
                                                      passwordController.text);
                                            }
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                                          },
                                          text: 'تسجيل الدخول',
                                          radius: 10,
                                          background:Theme.of(context).secondaryHeaderColor,
                                        ),
                                        fallback: (context) =>  Center(
                                            child: SpinKitCubeGrid(
                                              color: Theme.of(context).secondaryHeaderColor,
                                          size: 50.0,
                                        )),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('لا يوجد لديك حساب ؟'),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SignUpScreen()));
                                              },
                                              child: const Text(
                                                'إنشاء حساب جديد',
                                                style: TextStyle(
                                                  color: MyTheme.primaryColor,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          },
        );
      },
    );
  }
}

class CustomNoInternet extends StatelessWidget {
  const CustomNoInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/image/noInternetlotie.json'),
        const Text(
          'تاكد من الاتصال بالانترنت',
          style: MyTheme.textStyle15,
        )
      ],
    )));
  }
}
