
import 'dart:io';

import 'package:detection_of_smuggled_medication/model/check_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../network/end_point.dart';
import '../../../network/errors/exceptions.dart';
import '../../../network/remote/dio_helper.dart';
import '../../constant/images.dart';
import 'home_state.dart';
import 'package:path/path.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  CheckModel? checkModel;

  void checkTheMedicine({
    required File image,
  }) async {
    try {
      emit(HomeLoadingDataState());
      // FormData formData = new FormData.fromMap({
      //   "file": await MultipartFile.fromFile(image.path,
      //     filename: basename(image.path)
      //   )});
      final res = await DioHelper.post(
        url: check,
        authorization: 'Token $token',
        data: {
          'file': await MultipartFile.fromFile(
            image.path,
            filename: basename(image.path),
            contentType: MediaType('image', 'jpeg'),
          )
        },
      );
      checkModel = CheckModel.fromJson(res.data);
      print(checkModel!.status);
      print('whhhhhhhhhhhyyyyyyyyyyyyyyyyyy');
      print(checkModel!.imagePath);
      emit(HomeSuccessDataState(CheckModel.fromJson(res.data)));
    } catch (e) {
      if (e is ServerException) {
        emit(HomeErrorDataState(e.errModel.errorMessage!));
      } else {
        emit(HomeErrorDataState('حدث خطا غير متوقع!'));
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






Future uploadImageToAPI(XFile image) async {
  return MultipartFile.fromFile(image.path,
      filename: image.path.split('/').last);
}

