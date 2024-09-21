import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/features/currentWeather/bloc/current_weather_bloc.dart';

class CurrentWeatherUi extends StatelessWidget {
  CurrentWeatherUi({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _bloc.add(CurrentWeatherGetDataEvent());
      },
    );
  }
  final CurrentWeatherBloc _bloc = CurrentWeatherBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.appName),
      ),
      body: BlocListener<CurrentWeatherBloc, CurrentWeatherState>(
        bloc: _bloc,
        listenWhen: (previous, current) =>
            current is CurrentWeatherErrorState ||
            current is CurrentWeatherLocationErrorState ||
            current is CurrentWeatherSuccessState,
        listener: (context, state) {
          if (state is CurrentWeatherLocationErrorState) {
            // Constant.showLongToast(state.msg);
          }
        },
        child: Center(
          child: Text("Weather screen"),
        ),
      ),
    );
  }
}
//https://api.openweathermap.org/data/2.5/weather?lat=18.5204&lon=73.8567&appid=b33ac0a35e7dd2ecbe6017a88425fb18
// https://api.openweathermap.org/data/2.5/weather?q=Pune,in&APPID=b33ac0a35e7dd2ecbe6017a88425fb18