import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial2/blocs/internet%20blocs/internet_event.dart';
import 'package:bloc_tutorial2/blocs/internet%20blocs/internet_state.dart';
import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetActiveEvent>((event, emit) => emit(InternetActiveState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetActiveEvent());
      }
      if (result == ConnectivityResult.none) {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
