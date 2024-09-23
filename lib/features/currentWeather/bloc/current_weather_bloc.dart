import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/common/failed_data_model.dart';
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/features/currentWeather/model/current_weather_data_model.dart';
import 'package:weatherapp/features/currentWeather/model/current_weather_uvi_data_model.dart';
import 'package:weatherapp/repo/api_repository.dart';
import 'package:weatherapp/repo/api_urls.dart';
import 'package:weatherapp/repo/response_handler.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  List<CurrentWeatherDataModel> wheatherAllDataList =
      <CurrentWeatherDataModel>[];
  List<CurrentWeatherUviDataModel> uviDataList = <CurrentWeatherUviDataModel>[];
  List<FailedDataModel> failedList = <FailedDataModel>[];
  CurrentWeatherBloc() : super(CurrentWeatherInitial()) {
    on<CurrentWeatherPemissionEvent>(currentWeatherPemissionEvent);
    on<CurrentWeatherGetDataEvent>(currentWeatherGetDataEvent);
    on<CurrentWeatherCovertDataEvent>(currentWeatherCovertDataEvent);
    on<CurrentWeatherAllDataEvent>(currentWeatherAllDataEvent);
    on<CurrentWeatherUVIDataEvent>(currentWeatherUVIDataEvent);
    on<CurrentWeatherCitySearchEvent>(currentWeatherCitySearchEvent);
  }

  FutureOr<void> currentWeatherPemissionEvent(
      CurrentWeatherPemissionEvent event, Emitter<CurrentWeatherState> emit) {
    emit(CurrentWeatherLoadingState());
  }

  FutureOr<void> currentWeatherGetDataEvent(
      CurrentWeatherGetDataEvent event, Emitter<CurrentWeatherState> emit) {}

  FutureOr<void> currentWeatherCovertDataEvent(
      CurrentWeatherCovertDataEvent event,
      Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherLoadingState());
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          event.position.latitude, event.position.longitude);
      Placemark placemark = placemarks[0];
      String address = '${placemark.subLocality}';
      emit(CurrentWeatherConvertState(converted: address));
    } catch (e) {
      emit(CurrentWeatherErrorState("Error fetching address: ${e.toString()}"));
    }
  }

  FutureOr<void> currentWeatherAllDataEvent(CurrentWeatherAllDataEvent event,
      Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherLoadingState());

    try {
      Map<String, dynamic> productsParameter = {
        "lat": event.lat,
        "lon": event.lon,
        "appid": Constant.openWeatherApiKey
      };

      var response = await ApiRepository()
          .getCommonMethodAPI(productsParameter, ApiUrls.weatherPath);
      if (response is Success) {
        CurrentWeatherDataModel data =
            response.response as CurrentWeatherDataModel;

        wheatherAllDataList.clear();
        wheatherAllDataList.add(data);

        emit(CurrentWeatherAllDataState(allData: wheatherAllDataList));
        print(">><< ${wheatherAllDataList.first.name}");
      } else if (response is Failure) {
        var failedResponse = response.errorResponse;
        print("Err ${failedResponse.toString()}");
        emit(CurrentWeatherErrorState(response.errorResponse.toString()));
        print("err ${response.errorResponse}");
      } else {
        emit(CurrentWeatherErrorState("An unknown error occurred"));
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      emit(CurrentWeatherErrorState("Error occurred: ${e.toString()}"));
    }
  }

  FutureOr<void> currentWeatherUVIDataEvent(CurrentWeatherUVIDataEvent event,
      Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherLoadingState());

    try {
      Map<String, dynamic> productsParameter = {
        "lat": event.lat,
        "lon": event.lon,
        "appid": Constant.openWeatherApiKey
      };

      var response = await ApiRepository()
          .getCommonMethodAPI(productsParameter, ApiUrls.weatherUviPath);
      if (response is Success) {
        CurrentWeatherUviDataModel data =
            response.response as CurrentWeatherUviDataModel;

        uviDataList.clear();
        uviDataList.add(data);

        emit(CurrentWeatherUVIState(uviData: uviDataList));
        print(">><< ${uviDataList.first.value}");
      } else if (response is Failure) {
        var failedResponse = response.errorResponse;
        print("Err ${failedResponse.toString()}");
        emit(CurrentWeatherErrorState(response.errorResponse.toString()));
        print("err ${response.errorResponse}");
      } else {
        emit(CurrentWeatherErrorState("An unknown error occurred"));
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      emit(CurrentWeatherErrorState("Error occurred: ${e.toString()}"));
    }
  }

  FutureOr<void> currentWeatherCitySearchEvent(
      CurrentWeatherCitySearchEvent event,
      Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherLoadingState());

    try {
      Map<String, dynamic> productsParameter = {
        "q": event.cityName,
        "appid": Constant.openWeatherApiKey
      };

      var response = await ApiRepository()
          .getCommonMethodAPI(productsParameter, ApiUrls.weatherPath);
      if (response is Success) {
        CurrentWeatherDataModel data =
            response.response as CurrentWeatherDataModel;

        wheatherAllDataList.clear();
        wheatherAllDataList.add(data);

        emit(CurrentWeatherAllDataState(allData: wheatherAllDataList));
        print("City - ${wheatherAllDataList.first.name}");
      } else if (response is Failure) {
        var failedResponse = response.errorResponse;
        print("Err ${failedResponse.toString()}");
        emit(CurrentWeatherErrorState(response.errorResponse.toString()));
        print("err ${response.errorResponse}");
      } else {
        emit(CurrentWeatherErrorState("An unknown error occurred"));
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      emit(CurrentWeatherErrorState("Error occurred: ${e.toString()}"));
    }
  }

  double convertWindSpeedToKmh(double speedInMps) {
    return speedInMps * 3.6;
  }

  String getWindDirection(int degrees) {
    if (degrees >= 337.5 || degrees < 22.5) {
      return 'N';
    } else if (degrees >= 22.5 && degrees < 67.5) {
      return 'NE';
    } else if (degrees >= 67.5 && degrees < 112.5) {
      return 'E';
    } else if (degrees >= 112.5 && degrees < 157.5) {
      return 'SE';
    } else if (degrees >= 157.5 && degrees < 202.5) {
      return 'S';
    } else if (degrees >= 202.5 && degrees < 247.5) {
      return 'SW';
    } else if (degrees >= 247.5 && degrees < 292.5) {
      return 'W';
    } else if (degrees >= 292.5 && degrees < 337.5) {
      return 'NW';
    } else {
      return 'N';
    }
  }
}
