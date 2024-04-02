import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:detection_of_smuggled_medication/screen/login_screen/login_screen.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import '../../network/local/cache_helper.dart';
import '../../shard/bloc_cubit/internet/inernet_cubit.dart';
import '../../shard/bloc_cubit/internet/internet_state.dart';
import '../../shard/bloc_cubit/signup/signup_cubit.dart';
import '../../shard/components/tools.dart';
import '../../shard/constant/images.dart';
import '../../shard/constant/theme.dart';
import '../../shard/constant/validinput.dart';
import 'package:flutter/material.dart';
import '../home_screen/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var useNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessDataState) {
          if (state.signUpModel.status == true) {
            ToastManager.showToast(
                state.signUpModel.message, ToastStates.SUCCESS);
            CacheHelper.saveData(key: 'login', value: true).then((value) => print('hi'));
            CacheHelper.saveData(key: 'token', value: state.signUpModel.token)
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
          } else if (state.signUpModel.status == false) {
            print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
            print(state.signUpModel.message);

            ToastManager.showToast(
                '${state.signUpModel.message}', ToastStates.ERROR);
          } else {
            ToastManager.showToast('حدث خطامتوقع', ToastStates.ERROR);
          }
        }

        if (state is SignUpErrorDataState) {
          ToastManager.showToast(state.error, ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return SafeArea(
                child: Scaffold(
              // backgroundColor: Colors.white,
              body: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: MyTheme.primaryColor,
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
                          decoration: const BoxDecoration(
                            color: MyTheme.secondryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('إنشاء حساب ',
                                    style: MyTheme.textStyle24.copyWith(
                                        color: MyTheme.primaryColor,
                                        shadows: const [
                                          Shadow(
                                              color: Colors.black,
                                              offset: Offset(1.5, 1.5),
                                              blurRadius: 5.5)
                                        ])),
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
                                      const SizedBox(height: 5),
                                      CustomTextFormAuth(
                                        hinttext: 'ادخل البريد الالكتروني',
                                        isNumber: false,
                                        borderRadius: 10,
                                        labeltext: 'البريد الالكتروني',
                                        mycontroller: emailController,
                                        obscureText: false,
                                        prefixIcon: Icons.person,
                                        valid: (val) {
                                          return validInput(
                                              val!, 3, 50, "password");
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      CustomTextFormAuth(
                                        hinttext: 'ادخل كـلمة السر',
                                        isNumber: false,
                                        labeltext: 'كلمة السر',
                                        borderRadius: 10,
                                        mycontroller: passwordController,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: SignUpCubit.get(context)
                                            .obscureText1,
                                        iconData:
                                            SignUpCubit.get(context).suffix1,
                                        onTapIcon: () {
                                          SignUpCubit.get(context)
                                              .changePasswordVisibility(
                                                  'field1');
                                        },
                                        valid: (val) {
                                          return validInput(
                                              val!, 0, 20, "password");
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      CustomTextFormAuth(
                                        hinttext: 'ادخل تاكيد كـلمة السر',
                                        isNumber: false,
                                        labeltext: 'تاكيد كلمة السر',
                                        borderRadius: 10,
                                        mycontroller: confirmPasswordController,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: SignUpCubit.get(context)
                                            .obscureText2,
                                        iconData:
                                            SignUpCubit.get(context).suffix2,
                                        onTapIcon: () {
                                          SignUpCubit.get(context)
                                              .changePasswordVisibility(
                                                  'field2');
                                        },
                                        valid: (val) {
                                          if (val != passwordController.text) {
                                            return 'تاكيد كلمة السر غير متطابقة لكلمة السر';
                                          }
                                          return validInput(
                                              val!, 0, 20, "password");
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      ConditionalBuilder(
                                        condition:
                                            state is! SignUpLoadingDataState,
                                        builder: (context) => defaultButton(
                                          fun: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              SignUpCubit.get(context).userSignUp(
                                                  username:
                                                      useNameController.text,
                                                  password:
                                                      passwordController.text,
                                                  confirmPassword:
                                                      confirmPasswordController
                                                          .text,
                                                  email: emailController.text);
                                            }
                                          },
                                          text: 'إنشاء  حساب ',
                                          radius: 10,
                                        ),
                                        fallback: (context) => const Center(
                                            child: SpinKitCubeGrid(
                                          color: MyTheme.primaryColor,
                                          size: 50.0,
                                        )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('لديك حساب بالفعل؟'),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              },
                                              child: const Text(
                                                'تسجيل الدخول',
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
