import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';

class DetailsPage extends StatelessWidget {
  final WeatherModel weather;
  const DetailsPage({super.key, required this.weather});

  String formatLocalTime(int timezoneOffsetSeconds) {
    final nowUtc = DateTime.now().toUtc();
    final local = nowUtc.add(Duration(seconds: timezoneOffsetSeconds));
    return DateFormat('EEE, MMM d • h:mm a').format(local);
  }

  String formatSunTime(int unixUtcSeconds, int timezoneOffsetSeconds) {
    final utc = DateTime.fromMillisecondsSinceEpoch(
      unixUtcSeconds * 1000,
      isUtc: true,
    );
    final local = utc.add(Duration(seconds: timezoneOffsetSeconds));
    return DateFormat.jm().format(local);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final isFav = provider.isFavorite(weather.cityName);

    final iconUrl =
        "https://openweathermap.org/img/wn/${weather.icon}@2x.png";

    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              if (isFav) {
                provider.removeFavorite(weather.cityName);
              } else {
                provider.addFavorite(weather.cityName);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Local time
            Text(
              "Local time: ${formatLocalTime(weather.timezoneOffset)}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Icon
            Image.network(
              iconUrl,
              width: 110,
              height: 110,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.cloud, size: 64),
            ),

            // Temp
            Text(
              "${weather.temperature.toStringAsFixed(1)}°${provider.useMetric ? 'C' : 'F'}",
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Description
            Text(
              weather.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Feels like
            Text(
              "Feels like: ${weather.feelsLike.toStringAsFixed(1)}°${provider.useMetric ? 'C' : 'F'}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Info rows
            _infoRow("Humidity", "${weather.humidity}%"),
            _infoRow("Wind Speed", "${weather.windSpeed} m/s"),
            _infoRow("Pressure", "${weather.pressure} hPa"),
            _infoRow(
              "Sunrise",
              formatSunTime(weather.sunrise, weather.timezoneOffset),
            ),
            _infoRow(
              "Sunset",
              formatSunTime(weather.sunset, weather.timezoneOffset),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
