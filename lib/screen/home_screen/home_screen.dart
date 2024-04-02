import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:detection_of_smuggled_medication/screen/medicine_details/medicine_details.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_cubit.dart';
import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_state.dart';
import 'package:detection_of_smuggled_medication/shard/components/tools.dart';
import 'package:detection_of_smuggled_medication/shard/constant/images.dart';
import 'package:detection_of_smuggled_medication/shard/constant/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No Image selected ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccessDataState) {
          if(state.checkModel.status ==true){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicineDetails(),
              ));
        }
          if(state.checkModel.status == false){
            ToastManager.showToast('${state.checkModel.error}', ToastStates.ERROR);
          }
        }
        if (state is HomeErrorDataState) {
          ToastManager.showToast(state.error, ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingDataState) {
          return CustomLoading();
        }
        return WillPopScope(
          onWillPop: () => exitMethode(context),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text(
                          'تنبيه',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'هل تريد تسجيل الخروج من الحساب؟',
                          style: TextStyle(fontSize: 15),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () {
                              CacheHelper.removeData(key: 'login').then((value) => print('hi'));

                              CacheHelper.removeData(key: 'token').then(
                                    (value) {
                                  if (value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                            (route) => false);
                                  }
                                },
                              );
                            },
                            child: Text('نعم'),
                            isDestructiveAction: true,
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('لا'),
                            isDefaultAction: true,
                          ),
                        ],
                        insetAnimationCurve: Curves.easeInOut,
                        insetAnimationDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'كشف الأدوية المهربة',
                        style: TextStyle(
                          color: MyTheme.secondryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Image.asset(
                  'assets/image/mmm.png',
                  fit: BoxFit.contain,
                  // color: Colors.black.withOpacity(.1),
                  height: 2500,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (image != null)
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      else
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Text(
                              'قم باختيار صورة',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      Text(token),
                      InkWell(
                        onTap: () {
                          buildAwesomeDialog(context).show();
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyTheme.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.qr_code_scanner_outlined,
                            size: MediaQuery.of(context).size.height / 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      defaultButton(
                          fun: () {
                            if (image == null) {
                              ToastManager.showToast(
                                  'يجب اختيار صوره', ToastStates.ERROR);
                            } else
                              HomeCubit.get(context)
                                  .checkTheMedicine(image: image!);
                          },
                          text: 'إفــحـص',
                          radius: 10),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> exitMethode(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'تنبيه',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'هل انت متأكد من الخروج من التطبيق؟',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('نعم'),
            isDestructiveAction: true,
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('لا'),
            isDefaultAction: true,
          ),
        ],
        insetAnimationCurve: Curves.easeInOut,
        insetAnimationDuration: Duration(milliseconds: 300),
      ),
    );

    return exitApp ?? false;
  }

  AwesomeDialog buildAwesomeDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        body: Container(
          margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.black12,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                        color: MyTheme.primaryColor,
                      ),
                      Text('إلتقاط صوره')
                    ],
                  ),
                ),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.black12,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: MyTheme.primaryColor,
                      ),
                      Text('معرض الصور')
                    ],
                  ),
                ),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ));
  }
}
