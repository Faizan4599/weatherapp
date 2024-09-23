part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherEvent {}

class CurrentWeatherPemissionEvent extends CurrentWeatherEvent {}

class CurrentWeatherGetDataEvent extends CurrentWeatherEvent {}

class CurrentWeatherCovertDataEvent extends CurrentWeatherEvent {
  Position position;
  CurrentWeatherCovertDataEvent({required this.position});
}

class CurrentWeatherAllDataEvent extends CurrentWeatherEvent {
  String lat;
  String lon;
  CurrentWeatherAllDataEvent({required this.lat, required this.lon});
}

class CurrentWeatherUVIDataEvent extends CurrentWeatherEvent {
  String lat;
  String lon;
  CurrentWeatherUVIDataEvent({required this.lat, required this.lon});
}

class CurrentWeatherCitySearchEvent extends CurrentWeatherEvent {
  final String cityName;
  CurrentWeatherCitySearchEvent({required this.cityName});
}
