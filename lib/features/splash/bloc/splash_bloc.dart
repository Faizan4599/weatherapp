import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashNavigateEvent>(splashNavigateEvent);
  }

  FutureOr<void> splashNavigateEvent(
      SplashNavigateEvent event, Emitter<SplashState> emit) async {
    try {
      print(">>>>>> $event");
      emit(SplashLoadingState());

      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isLocationEnabled) {
        emit(SplashErrorState(err: "Location services are not enabled"));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(SplashErrorState(err: "Permission is denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(SplashErrorState(err: "Permission is permanently denied"));
        return;
      }

      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        emit(SplashNavigateToState(position));
      } catch (e) {
        print("Error ${e.toString()}");
        emit(SplashErrorState(err: e.toString()));
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
  }
}
