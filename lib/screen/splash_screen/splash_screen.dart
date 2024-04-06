import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:detection_of_smuggled_medication/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../../network/local/cache_helper.dart';
import '../../shard/constant/images.dart';
import '../../shard/constant/theme.dart';
import '../login_screen/login_screen.dart';

class Splash_Screen extends StatelessWidget {
  final bool login;
   Splash_Screen({Key? key ,required this.login}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
            backgroundColor: Theme.of(context).primaryColor,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
            child: Image(
              image: AssetImage(Images.logo),
              fit: BoxFit.fill,
            ),
          ),
          Text('كشف الأدوية المهربة',
              style: MyTheme.textStyle24),
        ],
      ),
      splashIconSize: MediaQuery.of(context).size.height,
      // nextScreen: Splash_Screen(),
      nextScreen: login == false  ?  LoginScreen() : HomeScreen()
    ));
  }
}