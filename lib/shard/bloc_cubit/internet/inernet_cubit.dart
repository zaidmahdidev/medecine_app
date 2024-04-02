import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool IS_CONNECTED=false;


class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitState()){
    print('object');
  }

  static InternetCubit get(context) => BlocProvider.of(context);


  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //
  // void initConnectivity() async {
  //   try {
  //     final ConnectivityResult result = await _connectivity.checkConnectivity();
  //
  //     bool isVpnActive = result == ConnectivityResult.vpn;
  //
  //     IS_CONNECTED = result != ConnectivityResult.none &&
  //         result != ConnectivityResult.other &&
  //         !isVpnActive;
  //
  //     emit(InternetConnectedState());
  //
  //     _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
  //       bool isVpnActive = result == ConnectivityResult.vpn;
  //
  //       IS_CONNECTED = result != ConnectivityResult.none &&
  //           result != ConnectivityResult.other &&
  //           !isVpnActive;
  //
  //       print('.................................................................');
  //       print(IS_CONNECTED);
  //       emit(InternetConnectedState());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }



  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initConnectivity () async {

    try {
      final ConnectivityResult result = await _connectivity.checkConnectivity();

      IS_CONNECTED = result != ConnectivityResult.none &&
          result != ConnectivityResult.other;
      emit(InternetConnectedState());


      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        IS_CONNECTED = result != ConnectivityResult.none &&
            result != ConnectivityResult.other;
        print('.................................................................');
        print(IS_CONNECTED);
        emit(InternetConnectedState());
      }


      );

    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }


}