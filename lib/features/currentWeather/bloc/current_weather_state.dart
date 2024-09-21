part of 'current_weather_bloc.dart';

@immutable
abstract class CurrentWeatherState {}

abstract class CurrentWeatherActionState extends CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherErrorState extends CurrentWeatherState {}

class CurrentWeatherLocationErrorState extends CurrentWeatherState {
  String msg;
  CurrentWeatherLocationErrorState({required this.msg});
}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherSuccessState extends CurrentWeatherState {}

class CurrentWeatherNavigateToState extends CurrentWeatherActionState {}
