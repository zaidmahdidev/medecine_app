// import 'dart:io';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:detection_of_smuggled_medication/screen/medicine_details/medicine_details.dart';
// import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_cubit.dart';
// import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_state.dart';
// import 'package:detection_of_smuggled_medication/shard/components/tools.dart';
// import 'package:detection_of_smuggled_medication/shard/constant/images.dart';
// import 'package:detection_of_smuggled_medication/shard/constant/theme.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../network/local/cache_helper.dart';
// import '../login_screen/login_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   File? image;
//
//   final picker = ImagePicker();
//
//
//   Future getImage(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);
//
//     setState(() {
//       if (pickedFile != null) {
//         image = File(pickedFile.path);
//       } else {
//         print('No Image selected ');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is HomeSuccessDataState) {
//           if(state.checkModel.status ==true){
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MedicineDetails(),
//               ));
//         }
//           if(state.checkModel.status == false){
//             ToastManager.showToast('${state.checkModel.error}', ToastStates.ERROR);
//           }
//         }
//         if (state is HomeErrorDataState) {
//           ToastManager.showToast(state.error, ToastStates.ERROR);
//         }
//       },
//       builder: (context, state) {
//         if (state is HomeLoadingDataState) {
//           return CustomLoading();
//         }
//         return WillPopScope(
//           onWillPop: () => exitMethode(context),
//           child: Scaffold(
//             appBar: AppBar(
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => CupertinoAlertDialog(
//                         title: Text(
//                           'تنبيه',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         content: Text(
//                           'هل تريد تسجيل الخروج من الحساب؟',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         actions: [
//                           CupertinoDialogAction(
//                             onPressed: () {
//                               CacheHelper.removeData(key: 'login').then((value) => print('hi'));
//
//                               CacheHelper.removeData(key: 'token').then(
//                                     (value) {
//                                   if (value) {
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => LoginScreen(),
//                                         ),
//                                             (route) => false);
//                                   }
//                                 },
//                               );
//                             },
//                             child: Text('نعم'),
//                             isDestructiveAction: true,
//                           ),
//                           CupertinoDialogAction(
//                             onPressed: () {
//                               Navigator.of(context).pop(false);
//                             },
//                             child: Text('لا'),
//                             isDefaultAction: true,
//                           ),
//                         ],
//                         insetAnimationCurve: Curves.easeInOut,
//                         insetAnimationDuration: Duration(milliseconds: 300),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.logout,
//                   ),
//                 ),
//               ],
//               shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(30)),
//               ),
//               bottom: PreferredSize(
//                 preferredSize: Size.fromHeight(70),
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//
//                       Text(
//                         'كشف الأدوية المهربة',
//                         style: TextStyle(
//                           color: MyTheme.secondryColor,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             body: Stack(
//               children: [
//                 Image.asset(
//                   'assets/image/mmm.png',
//                   fit: BoxFit.contain,
//                   // color: Colors.black.withOpacity(.1),
//                   height: 2500,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       if (image != null)
//                         Container(
//                           height: MediaQuery.of(context).size.height / 3,
//                           width: MediaQuery.of(context).size.width / 1.5,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 5,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.file(
//                               image!,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         )
//                       else
//                         Container(
//                           height: MediaQuery.of(context).size.height / 3,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.withOpacity(0.3),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'قم باختيار صورة',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       SizedBox(height: 20),
//                       Text(token),
//                       InkWell(
//                         onTap: () {
//                           buildAwesomeDialog(context).show();
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: MyTheme.primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 5,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.qr_code_scanner_outlined,
//                             size: MediaQuery.of(context).size.height / 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//
//
//                       Spacer(),
//                       defaultButton(
//                           fun: () {
//                             if (image == null) {
//                               ToastManager.showToast(
//                                   'يجب اختيار صوره', ToastStates.ERROR);
//                             } else
//                               HomeCubit.get(context)
//                                   .checkTheMedicine(image: image!);
//                           },
//                           text: 'إفــحـص',
//                           radius: 10),
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<bool> exitMethode(BuildContext context) async {
//     bool exitApp = await showDialog(
//       context: context,
//       builder: (context) => CupertinoAlertDialog(
//         title: Text(
//           'تنبيه',
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: Text(
//           'هل انت متأكد من الخروج من التطبيق؟',
//           style: TextStyle(fontSize: 15),
//         ),
//         actions: [
//           CupertinoDialogAction(
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//             child: Text('نعم'),
//             isDestructiveAction: true,
//           ),
//           CupertinoDialogAction(
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//             child: Text('لا'),
//             isDefaultAction: true,
//           ),
//         ],
//         insetAnimationCurve: Curves.easeInOut,
//         insetAnimationDuration: Duration(milliseconds: 300),
//       ),
//     );
//
//     return exitApp ?? false;
//   }
//
//   AwesomeDialog buildAwesomeDialog(BuildContext context) {
//     return AwesomeDialog(
//         context: context,
//         dialogType: DialogType.noHeader,
//         body: Container(
//           margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
//           child: Row(
//             children: [
//               Expanded(
//                   child: InkWell(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   color: Colors.black12,
//                   child: Column(
//                     children: const [
//                       Icon(
//                         Icons.camera_alt_outlined,
//                         size: 50,
//                         color: MyTheme.primaryColor,
//                       ),
//                       Text('إلتقاط صوره')
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   getImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//               )),
//               const SizedBox(width: 10),
//               Expanded(
//                   child: InkWell(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   color: Colors.black12,
//                   child: Column(
//                     children: const [
//                       Icon(
//                         Icons.image_outlined,
//                         size: 50,
//                         color: MyTheme.primaryColor,
//                       ),
//                       Text('معرض الصور')
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   getImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//               )),
//             ],
//           ),
//         ));
//   }
// }
//
//
//
//
// // import 'dart:io';
// //
// // import 'package:awesome_dialog/awesome_dialog.dart';
// // import 'package:detection_of_smuggled_medication/screen/medicine_details/medicine_details.dart';
// // import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_cubit.dart';
// // import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_state.dart';
// // import 'package:detection_of_smuggled_medication/shard/components/tools.dart';
// // import 'package:detection_of_smuggled_medication/shard/constant/images.dart';
// // import 'package:detection_of_smuggled_medication/shard/constant/theme.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// //
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../network/local/cache_helper.dart';
// // import '../login_screen/login_screen.dart';
// //
// //
// //
// //
// //
// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final picker = ImagePicker();
// //
// //   List<XFile>? selectedImages;
// //   List<String> imagePaths = [];
// //
// //   Future<void> pickMultipleImages() async {
// //     try {
// //       final pickedFiles = await picker.pickMultiImage(
// //
// //       );
// //       if (pickedFiles != null) {
// //         setState(() {
// //           selectedImages = List<XFile>.from(pickedFiles);
// //           imagePaths = selectedImages!.map((image) => image.path).toList();
// //         });
// //       } else {
// //         print('No images selected');
// //       }
// //     } catch (e) {
// //       print('Error picking multiple images: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Selected Images'),
// //       ),
// //       body: Column(
// //         children: [
// //           ElevatedButton(
// //             onPressed: pickMultipleImages,
// //             child: Text('Select Images'),
// //           ),
// //           if (selectedImages != null)
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: imagePaths.length,
// //                 itemBuilder: (context, index) {
// //                   return Container(
// //                     padding: EdgeInsets.all(8.0),
// //                     child: Image.file(File(imagePaths[index])),
// //                   );
// //                 },
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }



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
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../../network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<XFile>? selectedImages;
  List<String> imagePaths = [];
  final picker = ImagePicker();


  Future<void> getImage() async {
    try {
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null) {
        List<XFile> newImages = List<XFile>.from(pickedFiles);
        List<String> newPaths = [];

        // Compress and add new images
        for (var image in newImages) {
          String compressedImagePath = await compressImage(image, 50); // تعديل الجودة حسب الحاجة
          newPaths.add(compressedImagePath);
        }

        setState(() {
          // Filter out already selected images
          selectedImages ??= [];
          newImages.removeWhere((newImage) => selectedImages!.any((selectedImage) => selectedImage.path == newImage.path));
          selectedImages!.addAll(newImages);

          // Filter out already selected image paths
          imagePaths ??= [];
          newPaths.removeWhere((newPath) => imagePaths.contains(newPath));
          imagePaths.addAll(newPaths);
        });
      } else {
        print('No images selected');
      }
    } catch (e) {
      print('Error picking multiple images: $e');
    }
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
              // backgroundColor: Theme.of(context).secondaryHeaderColor,
              leading: IconButton(onPressed: (){
                HomeCubit.get(context).changMode();
              },  icon: HomeCubit.get(context).isDark ? Icon(Icons.light_mode , color: Colors.white ,size: 30,):Icon(Icons.dark_mode , color: Colors.white ,size: 30,)
              ),
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
                      if (selectedImages != null)
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
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
                          child: GridView.builder(
                            itemCount: selectedImages!.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5
                            ),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(imagePaths[index]),
                                      fit: BoxFit.cover ,height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),


                                  ),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: IconButton(
                                      icon: Icon(Icons.delete , color: Colors.red,),
                                      onPressed: () {
                                        setState(() {
                                          selectedImages!.removeAt(index);
                                          imagePaths.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
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
                              'قم باختيار 6 صور',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20),

                      InkWell(
                        onTap: () {
                          // buildAwesomeDialog(context).show();
                          getImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).secondaryHeaderColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),


                      Spacer(),
                      defaultButton(
                          fun: () {
                            if (selectedImages == null) {
                              ToastManager.showToast(
                                  'يجب اختيار صوره', ToastStates.ERROR);
                            } else if(selectedImages!.length < 6){
                              ToastManager.showToast(
                                  'يجب اختيار 6 صور', ToastStates.ERROR);
                            }else if(selectedImages!.length > 6){
                              ToastManager.showToast(
                                  'يجب اختيار 6 صور فقط', ToastStates.ERROR);
                            }else
                              HomeCubit.get(context)
                                  .checkTheMedicine(images: selectedImages!,);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => MedicineDetails(),
                            //     ));
                          },
                          text: 'إفــحـص',
                          radius: 10,
                      background:  Theme.of(context).secondaryHeaderColor,
                      ),

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

  // AwesomeDialog buildAwesomeDialog(BuildContext context) {
  //   return AwesomeDialog(
  //       context: context,
  //       dialogType: DialogType.noHeader,
  //       body: Container(
  //         margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: InkWell(
  //                   child: Container(
  //                     padding: const EdgeInsets.all(20),
  //                     color: Colors.black12,
  //                     child: Column(
  //                       children:  [
  //                         Icon(
  //                           Icons.camera_alt_outlined,
  //                           size: 50,
  //                           color: Theme.of(context).secondaryHeaderColor,
  //                         ),
  //                         Text('إلتقاط صوره')
  //                       ],
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     getImage(ImageSource.camera);
  //                     Navigator.pop(context);
  //                   },
  //                 )),
  //             const SizedBox(width: 10),
  //             Expanded(
  //                 child: InkWell(
  //                   child: Container(
  //                     padding: const EdgeInsets.all(20),
  //                     color: Colors.black12,
  //                     child: Column(
  //                       children:  [
  //                         Icon(
  //                           Icons.image_outlined,
  //                           size: 50,
  //                           color: Theme.of(context).secondaryHeaderColor,
  //                         ),
  //                         Text('معرض الصور')
  //                       ],
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     getImage(ImageSource.gallery);
  //                     Navigator.pop(context);
  //                   },
  //                 )),
  //           ],
  //         ),
  //       ));
  // }
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