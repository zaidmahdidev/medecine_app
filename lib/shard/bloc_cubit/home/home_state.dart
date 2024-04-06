import 'package:detection_of_smuggled_medication/model/check_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingDataState extends HomeState {}

class HomeSuccessDataState extends HomeState {
  final CheckModel checkModel;
  HomeSuccessDataState(this.checkModel);
}

class HomeErrorDataState extends HomeState {
  final String error;
  HomeErrorDataState(this.error);
}


///////////////////////// theme //////////////////////
class ChangeModeState extends HomeState {}



//////////////////////////  rating  ////////////////////////

class RatingLoadingDataState extends HomeState {}

class RatingSuccessDataState extends HomeState {}

class RatingErrorDataState extends HomeState {
  final String error;
  RatingErrorDataState(this.error);
}


////////////////////////
class UploadProfilePic extends HomeState {}