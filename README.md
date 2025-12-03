# Weather App (Assignment 3)

A Flutter weather application using OpenWeatherMap Current Weather API.
Users can search for any city, view detailed weather information, save favorite cities, and change temperature units.

---

## Features
- Search weather by city name.
- Current weather details:
  - Temperature
  - Weather description & icon
  - Humidity
  - Wind speed
  - Pressure
  - Sunrise / Sunset time
- Favorites:
  - Add/remove favorite cities
  - Persisted locally using SharedPreferences
- Settings:
  - Toggle temperature units (Celsius / Fahrenheit)
  - Persisted locally

---

## Project Structure
lib/
- models/
  - weather_model.dart
- services/
  - weather_service.dart
- providers/
  - weather_provider.dart
- pages/
  - home_page.dart
  - details_page.dart
  - favorites_page.dart
  - settings_page.dart
- config/
  - api_constants.dart

---

## API
Endpoint used:
- Current Weather Data  
`https://api.openweathermap.org/data/2.5/weather`

---

## Setup & Run
1. Clone the project
2. Add your OpenWeather API key in:
   `lib/config/api_constants.dart`

```dart
static const String apiKey = "dd7634625e7fde1188850e23b3896569";
