import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/features/currentWeather/bloc/current_weather_bloc.dart';

class CurrentWeatherUi extends StatelessWidget {
  final Position position;
  CurrentWeatherUi({super.key, required this.position}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _bloc.add(CurrentWeatherCovertDataEvent(position: position));
        _bloc.add(
          CurrentWeatherAllDataEvent(
              lat: position.latitude.toString(),
              lon: position.longitude.toString()),
        );
        _bloc.add(CurrentWeatherUVIDataEvent(
            lat: position.latitude.toString(),
            lon: position.longitude.toString()));
      },
    );
  }

  final _bloc = CurrentWeatherBloc();
  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.location_on,
                color: Colors.black,
              ),
            )
          ],
          title: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            bloc: _bloc,
            buildWhen: (previous, current) =>
                current is CurrentWeatherConvertState,
            builder: (context, state) {
              return Text(
                state is CurrentWeatherConvertState
                    ? state.converted
                    : "Fetching...",
                style: const TextStyle(fontSize: 30),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 80,
                // ),
                TextField(
                  style: const TextStyle(color: Colors.black54),
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: const TextStyle(color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        String cityName = _cityController.text;
                        if (cityName.isNotEmpty) {
                          _bloc.add(CurrentWeatherCitySearchEvent(
                              cityName: cityName));
                        }
                      },
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                      bloc: _bloc,
                      buildWhen: (previous, current) =>
                          current is CurrentWeatherAllDataState,
                      builder: (context, state) {
                        if (state is CurrentWeatherAllDataState) {
                          final double tempKelvin =
                              state.allData.first.main?.temp ?? 0.0;
                          final double tempCelsius = tempKelvin - 273.15;
                          final String weatherDescription =
                              state.allData.first.weather?.first.description ??
                                  "";

                          return Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    tempCelsius.toStringAsFixed(0),
                                    style: const TextStyle(
                                      fontSize: 70,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "°C",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    weatherDescription,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        } else {
                          // return const Text("Fetching weather data...");
                          return Center(
                            child:
                                Constant.spinKitLoader(context, Colors.black54),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                  bloc: _bloc,
                  buildWhen: (previous, current) =>
                      current is CurrentWeatherAllDataState,
                  builder: (context, state) {
                    if (state is CurrentWeatherAllDataState) {
                      final double tempKelvin =
                          state.allData.first.main?.temp ?? 0.0;
                      final double tempCelsius = tempKelvin - 273.15;
                      final int humidity =
                          state.allData.first.main?.humidity ?? 0;
                      return Column(
                        children: [
                          const Row(
                            children: [Text("Wheather details")],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Feels like",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${tempCelsius.toStringAsFixed(0)}°C",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Humidity",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${humidity.toString()}%",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: _bloc.getWindDirection(
                                            state.allData.first.wind?.deg ?? 0),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                      const TextSpan(
                                        text: " wind",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ]),
                                  ),
                                  Text(
                                    "${_bloc.convertWindSpeedToKmh(state.allData.first.wind?.speed ?? 0.0).toStringAsFixed(1)} km/h",
                                    style: const TextStyle(fontSize: 27),
                                  ),
                                ],
                              ),
                              BlocBuilder<CurrentWeatherBloc,
                                  CurrentWeatherState>(
                                bloc: _bloc,
                                buildWhen: (previous, current) =>
                                    current is CurrentWeatherUVIState,
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      const Text(
                                        "UV",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        _bloc.uviDataList.isNotEmpty
                                            ? _bloc.uviDataList.first
                                                .getUvDescription()
                                            : "Unknown",
                                        style: TextStyle(fontSize: 27),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Visibility",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    state is CurrentWeatherAllDataState
                                        ? " ${state.allData.first.visibility! / 1000} km"
                                        : "0 km",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Air Pressure",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${state.allData.first.main?.pressure ?? "Unknown"} hPa",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      return const Text("Getting the latest weather update...");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
//https://api.openweathermap.org/data/2.5/weather?lat=18.5204&lon=73.8567&appid=b33ac0a35e7dd2ecbe6017a88425fb18
// https://api.openweathermap.org/data/2.5/weather?q=Pune,in&APPID=b33ac0a35e7dd2ecbe6017a88425fb18


