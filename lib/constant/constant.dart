import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {
  static const appName = "Weather App";
  static const mainBaseUrl = "https://api.openweathermap.org";
  static const openWeatherApiKey = "b33ac0a35e7dd2ecbe6017a88425fb18";
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static spinKitLoader(BuildContext context, Color color) {
    return Center(
      child: SpinKitWave(
        color: color,
        size: 25.0,
      ),
    );
  }

  static void showLongToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void showShortToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
