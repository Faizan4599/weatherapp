part of 'current_weather_bloc.dart';

@immutable
abstract class CurrentWeatherEvent {}

class CurrentWeatherGetDataEvent extends CurrentWeatherEvent {}

class CurrentWeatherHandleLocationPermissionEvent extends CurrentWeatherEvent {}
