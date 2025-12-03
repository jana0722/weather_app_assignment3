import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherModel? weather;
  bool isLoading = false;
  String? error;

  // Favorites (list of city names)
  List<String> favorites = [];

  // Units setting
  bool useMetric = true; // true = Celsius, false = Fahrenheit

  WeatherProvider() {
    _loadFavorites();
    _loadUnits();
  }

  Future<void> getWeather(String cityName) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      weather = await _service.fetchWeatherByCity(
        cityName,
        useMetric: useMetric,
      );
    } catch (e) {
      error = e.toString();
      weather = null;
    }

    isLoading = false;
    notifyListeners();
  }

  // ---------- Favorites ----------
  Future<void> addFavorite(String city) async {
    if (!favorites.contains(city)) {
      favorites.add(city);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String city) async {
    favorites.remove(city);
    await _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String city) => favorites.contains(city);

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  // ---------- Units ----------
  Future<void> toggleUnits() async {
    useMetric = !useMetric;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useMetric', useMetric);
    notifyListeners();
  }

  Future<void> _loadUnits() async {
    final prefs = await SharedPreferences.getInstance();
    useMetric = prefs.getBool('useMetric') ?? true;
    notifyListeners();
  }
}
