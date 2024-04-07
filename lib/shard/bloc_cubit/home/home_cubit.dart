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




