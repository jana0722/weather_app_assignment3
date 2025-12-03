import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListTile(
        title: const Text("Temperature Unit"),
        subtitle: Text(provider.useMetric ? "Celsius (°C)" : "Fahrenheit (°F)"),
        trailing: Switch(
          value: provider.useMetric,
          onChanged: (_) => provider.toggleUnits(),
        ),
      ),
    );
  }
}
