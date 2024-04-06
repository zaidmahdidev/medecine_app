//
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:detection_of_smuggled_medication/model/check_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../network/end_point.dart';
// import '../../../network/errors/exceptions.dart';
// import '../../../network/remote/dio_helper.dart';
// import '../../constant/images.dart';
// import 'home_state.dart';
// import 'package:path/path.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:mime/mime.dart';
//
//
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitState());
//
//   static HomeCubit get(context) => BlocProvider.of(context);
//
//
//   // XFile? image;
//   // XFile? recordDocumentImage;
//   // XFile? otherAttachments;
//   //
//   //
//   // void uploadImageFile(XFile image) async {
//   //
//   //   int compressionQuality = 50;
//   //
//   //   String compressedImagePath;
//   //
//   //     compressedImagePath = await compressImage(image, compressionQuality);
//   //
//   //       image = XFile(compressedImagePath);
//   //
//   //
//   //   emit(UploadProfilePic());
//   // }
//
//
//
//
//   CheckModel? checkModel;
//
//   void checkTheMedicine({
//     required File image,
//   }) async {
//     try {
//       emit(HomeLoadingDataState());
//       FormData formData = new FormData.fromMap({
//         "file" : await MultipartFile.fromFile(image.path,
//           filename: basename(image.path),
//           contentType: MediaType("image", "jpg")
//         )});
//       final res = await DioHelper.post(
//         url: check,
//         authorization: 'Token $token',
//         data: formData,
//       );
//       checkModel = CheckModel.fromJson(res.data);
//       print(checkModel!.status);
//
//       print(checkModel!.imagePath);
//       emit(HomeSuccessDataState(CheckModel.fromJson(res.data)));
//     } catch (e) {
//       if (e is ServerException) {
//         emit(HomeErrorDataState(e.errModel.errorMessage!));
//       } else {
//         emit(HomeErrorDataState('حدث خطا غير متوقع!'));
//       }
//     }
//   }
//
//
//
//   void addRating({
//     required int stars,
//     required String comment,
//   }) async {
//     try {
//       emit(RatingLoadingDataState());
//
//       final res = await DioHelper.post(
//         url: rating,
//         authorization: 'Token $token',
//         data: {
//           'stars' : stars,
//           'comment' : comment
//         },
//       );
//       checkModel = CheckModel.fromJson(res.data);
//
//       print('😂😂😂😂😂');
//
//       emit(RatingSuccessDataState());
//     } catch (e) {
//       emit(RatingErrorDataState('حدث خطا غير متوقع!'));
//       // if (e is ServerException) {
//       //   emit(RatingErrorDataState(e.errModel.errorMessage!));
//       // } else {
//       //   emit(RatingErrorDataState('حدث خطا غير متوقع!'));
//       // }
//     }
//   }
// }
//
//
// class UploadImageHelper {
//   static Future<XFile?> pickerImage() async {
//     XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) return image;
//     return null;
//   }
//
//
//   static Future<MultipartFile> uploadSingleImage({
//     required XFile image,
//   }) async {
//     print('--------------------------------------------');
//     print("uploadSingleImage");
//     print('--------------------------------------------');
//     Uint8List byteData = await image.readAsBytes();
//     // Compress the image
//     List<int> compressedImageData = await FlutterImageCompress.compressWithList(
//       byteData,
//       quality: 70,
//     );
//     MultipartFile file = MultipartFile.fromBytes(
//       compressedImageData,
//       filename: image.name,
//     );
//
//     return file;
//   }
//
//   ///upload Multi Image
//   static Future<List<MultipartFile>> uploadMultiImage({
//     required List<XFile> images,
//   }) async {
//     List<MultipartFile> files = [];
//
//     for (XFile image in images) {
//       Uint8List byteData = await image.readAsBytes();
//       List<int> compressedImageData =
//       await FlutterImageCompress.compressWithList(
//         byteData,
//         quality: 70,
//       );
//       MultipartFile file = MultipartFile.fromBytes(
//         compressedImageData,
//         filename: image.name,
//       );
//       files.add(file);
//     }
//     return files;
//   }
// }
//
//
// Future<String> compressImage(XFile imageFile, int quality) async {
//   final tempDir = Directory.systemTemp;
//   final tempPath = tempDir.path;
//   final fileName = imageFile.path.split('/').last;
//   final compressedImagePath = '$tempPath/$fileName';
//
//   await FlutterImageCompress.compressAndGetFile(
//     imageFile.path,
//     compressedImagePath,
//     quality: quality,
//   );
//
//   return compressedImagePath;
// }
//
//





import 'dart:io';
import 'dart:typed_data';

import 'package:detection_of_smuggled_medication/model/check_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../network/end_point.dart';
import '../../../network/errors/exceptions.dart';
import '../../../network/local/cache_helper.dart';
import '../../../network/remote/dio_helper.dart';
import '../../constant/images.dart';
import 'home_state.dart';
import 'package:path/path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);



  bool isDark =  CacheHelper.getData(key: 'isDark') ?? false;


  void changMode(){
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark );
    emit(ChangeModeState());

  }

  // XFile? image;
  // XFile? recordDocumentImage;
  // XFile? otherAttachments;
  //
  //
  // void uploadImageFile(XFile image) async {
  //
  //   int compressionQuality = 50;
  //
  //   String compressedImagePath;
  //
  //     compressedImagePath = await compressImage(image, compressionQuality);
  //
  //       image = XFile(compressedImagePath);
  //
  //
  //   emit(UploadProfilePic());
  // }




  CheckModel? checkModel;

  void checkTheMedicine({
    required List<XFile> images,
  }) async {
    try {
      emit(HomeLoadingDataState());
      List<MultipartFile> multipartImages = [];
      for (var image in images) {
        multipartImages.add(
          await MultipartFile.fromFile(
            image.path,
            filename: basename(image.path),
            contentType: MediaType("image", "jpg"),
          ),
        );
      }
      FormData formData = new FormData();
      for (var i = 0; i < multipartImages.length; i++) {
        formData.files.add(MapEntry(
          'Images',
          multipartImages[i],
        ));
      }
      final res = await DioHelper.post(
        url: check,
        authorization: 'Token $token',
        data: formData,
      );
      checkModel = CheckModel.fromJson(res.data);
      print(checkModel!.status);
      print(checkModel!.imagePath);
      emit(HomeSuccessDataState(CheckModel.fromJson(res.data)));
    } catch (e) {
      if (e is ServerException) {
        emit(HomeErrorDataState(e.errModel.errorMessage!));
      } else {
        emit(HomeErrorDataState('حدث خطأ غير متوقع!'));
      }
    }
  }



  void addRating({
    required int stars,
    required String comment,
  }) async {
    try {
      emit(RatingLoadingDataState());

      final res = await DioHelper.post(
        url: rating,
        authorization: 'Token $token',
        data: {
          'stars' : stars,
          'comment' : comment
        },
      );
      checkModel = CheckModel.fromJson(res.data);

      print('😂😂😂😂😂');

      emit(RatingSuccessDataState());
    } catch (e) {
      emit(RatingErrorDataState('حدث خطا غير متوقع!'));
      // if (e is ServerException) {
      //   emit(RatingErrorDataState(e.errModel.errorMessage!));
      // } else {
      //   emit(RatingErrorDataState('حدث خطا غير متوقع!'));
      // }
    }
  }
}



Future<List<MultipartFile>> uploadMultiImage({
  required List<XFile> images,
}) async {
  List<MultipartFile> files = [];

  for (XFile image in images) {
    Uint8List byteData = await image.readAsBytes();
    List<int> compressedImageData =
    await FlutterImageCompress.compressWithList(
      byteData,
      quality: 70,
    );
    MultipartFile file = MultipartFile.fromBytes(
      compressedImageData,
      filename: image.name,
    );
    files.add(file);
  }
  return files;
}


class UploadImageHelper {
  static Future<XFile?> pickerImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) return image;
    return null;
  }


  static Future<MultipartFile> uploadSingleImage({
    required XFile image,
  }) async {
    print('--------------------------------------------');
    print("uploadSingleImage");
    print('--------------------------------------------');
    Uint8List byteData = await image.readAsBytes();
    // Compress the image
    List<int> compressedImageData = await FlutterImageCompress.compressWithList(
      byteData,
      quality: 70,
    );
    MultipartFile file = MultipartFile.fromBytes(
      compressedImageData,
      filename: image.name,
    );

    return file;
  }

  ///upload Multi Image
  static Future<List<MultipartFile>> uploadMultiImage({
    required List<XFile> images,
  }) async {
    List<MultipartFile> files = [];

    for (XFile image in images) {
      Uint8List byteData = await image.readAsBytes();
      List<int> compressedImageData =
      await FlutterImageCompress.compressWithList(
        byteData,
        quality: 70,
      );
      MultipartFile file = MultipartFile.fromBytes(
        compressedImageData,
        filename: image.name,
      );
      files.add(file);
    }
    return files;
  }
}





