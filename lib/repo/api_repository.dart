import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/features/currentWeather/model/current_weather_data_model.dart';
import 'package:weatherapp/features/currentWeather/model/current_weather_uvi_data_model.dart';
import 'package:weatherapp/repo/api_urls.dart';
import 'package:weatherapp/repo/response_handler.dart';

class ApiRepository {
  Future<dynamic> getCommonMethodAPI(
      Map<String, dynamic> parameters, String endpoint) async {
    try {
      final String url = Constant.mainBaseUrl + endpoint;
      Uri uri = Uri.parse(url);
      final finalUri = uri.replace(queryParameters: parameters);
      final response = await http.get(finalUri);

      var jsonMap = json.decode(response.body);
      print("API --$uri");
      print("Parameters--$parameters");
      print("Body ${response.body}");
      if (response.statusCode == 200) {
        switch (endpoint) {
          case ApiUrls.weatherPath:
            return Success(
              code: APICode.SUCCESS,
              response: CurrentWeatherDataModel.fromJson(jsonMap),
            );
          case ApiUrls.weatherUviPath:
            return Success(
              code: APICode.SUCCESS,
              response: CurrentWeatherUviDataModel.fromJson(jsonMap),
            );
          default:
            return Failure(
                code: APICode.UNKNOWN_ERROR, errorResponse: "Unknown Error");
        }
      } else {
        return Failure(
            code: APICode.INVALID_REPONSE, errorResponse: "Invalid Response");
      }
    } on HttpException {
      return Failure(code: APICode.NO_INTERNET, errorResponse: "No Internet");
    } on FormatException {
      return Failure(
          code: APICode.INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(
          code: APICode.UNKNOWN_ERROR,
          errorResponse: "Unknown Error ${e.toString()}");
    }
  }
}
