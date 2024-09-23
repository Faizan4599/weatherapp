import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/features/currentWeather/ui/current_weather_ui.dart';
import 'package:weatherapp/features/splash/bloc/splash_bloc.dart';
import 'package:weatherapp/widgets/dialog.dart';

class SplashUi extends StatefulWidget {
  SplashUi({super.key});

  @override
  _SplashUiState createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> with WidgetsBindingObserver {
  final _spalshBloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _spalshBloc.add(SplashNavigateEvent());
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Recheck location services when app is resumed
      _spalshBloc.add(SplashNavigateEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appName,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(
          bloc: _spalshBloc,
          listener: (context, state) {
            if (state is SplashNavigateToState) {
              Future.delayed(const Duration(seconds: 3));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrentWeatherUi(
                    position: state.position,
                  ),
                ),
              );
            } else if (state is SplashErrorState) {
              if (state.err == "Location services are not enabled") {
                // _showLocationDialog(context);
                showLocationDialog(context, onPressed: () {
                  Navigator.pop(context);
                  Geolocator.openLocationSettings();
                },
                    buttonTitle: "Go to Settings",
                    content:
                        "Location services are disabled. Please enable them in settings.",
                    title: "Enable Location");
              } else {
                Constant.showLongToast(state.err);
              }
            }
          },
          builder: (context, state) {
            return const Center(
              child: Text(Constant.appName),
            );
          },
        ),
      ),
    );
  }
}
