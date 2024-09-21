import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/constant/constant.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurrentWeatherInitial()) {
    on<CurrentWeatherGetDataEvent>(currentWeatherGetDataEvent);
    on<CurrentWeatherHandleLocationPermissionEvent>(
        currentWeatherHandleLocationPermissionEvent);
  }
  String? _currentAddress;
  Position? _currentPosition;
  FutureOr<void> currentWeatherGetDataEvent(
      CurrentWeatherGetDataEvent event, Emitter<CurrentWeatherState> emit) {
    try {
      // _handleLocationPermission();
      _getCurrentPosition();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> _handleLocationPermission() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Constant.showLongToast(
            "Location services are disabled. Please enable the services");
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Constant.showLongToast('Location permissions are denied');
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Constant.showLongToast(
            'Location permissions are permanently denied, we cannot request permissions.');
        return false;
      }
      return true;
    } catch (e) {
      print("Error ${e.toString()}");
      return false;
    }
  }

  Future<void> _getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
     _currentPosition = position;
     print(">>>>>>>>>>>>>>>>${position}");
  }).catchError((e) {
    print(e.toString());
  });
}

  FutureOr<void> currentWeatherHandleLocationPermissionEvent(
      CurrentWeatherHandleLocationPermissionEvent event,
      Emitter<CurrentWeatherState> emit) {}
}
