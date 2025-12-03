import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_constants.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> fetchWeatherByCity(
    String cityName, {
    required bool useMetric,
  }) async {
    final units = useMetric ? "metric" : "imperial";

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}?q=$cityName&appid=${ApiConstants.apiKey}&units=$units",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      final errorData = jsonDecode(response.body);
      final message = errorData["message"] ?? "Something went wrong";
      throw Exception(message);
    }
  }
}
