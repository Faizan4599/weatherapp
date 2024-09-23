part of 'current_weather_bloc.dart';

@immutable
sealed class CurrentWeatherState {}

sealed class CurrentWeatherActionState extends CurrentWeatherState {}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherErrorState extends CurrentWeatherState {
  final String error;
  CurrentWeatherErrorState(this.error);
}

final class CurrentWeatherLoadingState extends CurrentWeatherState {}

final class CurrentWeatherSuccessState extends CurrentWeatherState {}

final class CurrentWeatherConvertState extends CurrentWeatherState {
  String converted;
  CurrentWeatherConvertState({required this.converted});
}

final class CurrentWeatherAllDataState extends CurrentWeatherState {
  List<CurrentWeatherDataModel> allData;
  CurrentWeatherAllDataState({required this.allData});
}

final class CurrentWeatherUVIState extends CurrentWeatherState {
  List<CurrentWeatherUviDataModel> uviData;
  CurrentWeatherUVIState({required this.uviData});
}

final class CurrentWeatherNavigateToState extends CurrentWeatherState {}
