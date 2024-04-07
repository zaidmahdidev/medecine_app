import 'dart:io';

import 'package:detection_of_smuggled_medication/shard/constant/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';



class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Theme.of(context).secondaryHeaderColor,
          size: 50.0,
        ),
      ),
    );
  }
}

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final IconData? prefixIcon;
  final String? Function(String?) valid;
  final IconData? suffixIcon;
  final Function? suffixPressed;
  final double borderRadius;

  const CustomTextFormAuth({
    Key? key,
    this.obscureText,
    this.onTapIcon,
    required this.hinttext,
    required this.labeltext,
    this.iconData,
    required this.mycontroller,
    required this.isNumber,
    this.prefixIcon,
    required this.valid,
    this.suffixIcon,
    this.suffixPressed,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        validator: valid,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          labelText: labeltext,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: InkWell(child: Icon(iconData), onTap: onTapIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

Future<String> compressImage(XFile imageFile, int quality) async {
  final tempDir = Directory.systemTemp;
  final tempPath = tempDir.path;
  final fileName = imageFile.path.split('/').last;
  final compressedImagePath = '$tempPath/$fileName';

  await FlutterImageCompress.compressAndGetFile(
    imageFile.path,
    compressedImagePath,
    quality: quality,
  );

  return compressedImagePath;
}


////////////////////////
class ToastManager {
  static bool isShowingToast = false;

  static void showToast(String message, ToastStates state) {
    if (!isShowingToast) {
      isShowingToast = true;

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
      ).then((value) {
        isShowingToast = false;
      });
    }
  }
}

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

/////////////////////////

Widget defaultButton({
  double width = double.infinity,
  Color background = MyTheme.primaryColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function fun,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          fun();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );



////////////////////////////