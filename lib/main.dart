import 'package:detection_of_smuggled_medication/screen/splash_screen/splash_screen.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/blocObserver.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_cubit.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_state.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/login/login_cubit.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/signup/signup_cubit.dart';
import 'package:detection_of_smuggled_medication/shard/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();


    runApp( MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  bool login = CacheHelper.getData(key: 'login') ?? false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
      ],
      child: BlocConsumer<HomeCubit,HomeState>(
        builder:(context, state) {
          return GetMaterialApp(

            themeMode:  HomeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,

            title: 'كشف الادويه المهربه',
            locale: const Locale('ar'),

            debugShowCheckedModeBanner: false,
            // home: BlocBuilder<InternetCubit,InternetState>(
            //   builder: (context, state) => !IS_CONNECTED? const Splash_Screen():const Scaffold(body: Center(child: Text('no Internet '),)),
            // ),
            home:  Splash_Screen(login: login),
            // home: IS_CONNECTED? Splash_Screen():Scaffold()
          );
        },
        listener: (context, state) {

        },
      )
    );
  }
}
