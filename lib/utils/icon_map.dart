import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

/// Mapeia o código OpenWeather para o ícone do weather_icons.
IconData obterIcone(String codigo) {
  switch (codigo) {
    case '01d': return WeatherIcons.day_sunny;
    case '01n': return WeatherIcons.night_clear;
    case '02d':
    case '02n': return WeatherIcons.cloudy;
    case '03d':
    case '03n':
    case '04d':
    case '04n': return WeatherIcons.cloud;
    case '09d':
    case '09n':
    case '10d':
    case '10n': return WeatherIcons.rain;
    case '11d':
    case '11n': return WeatherIcons.thunderstorm;
    case '13d':
    case '13n': return WeatherIcons.snow;
    case '50d':
    case '50n': return WeatherIcons.fog;
    default: return WeatherIcons.na;
  }
}

/// Cor por condição climática
Color obterCor(String codigo) {
  switch (codigo) {
    case '01d': // sol dia
      return Colors.amber;
    case '01n': // céu claro à noite
      return Colors.indigoAccent;
    case '02d':
    case '02n': // poucas nuvens
      return Colors.grey.shade400;
    case '03d':
    case '03n':
    case '04d':
    case '04n': // nublado
      return Colors.blueGrey;
    case '09d':
    case '09n':
    case '10d':
    case '10n': // chuva
      return Colors.blue;
    case '11d':
    case '11n': // tempestade
      return Colors.deepPurple;
    case '13d':
    case '13n': // neve
      return Colors.lightBlueAccent;
    case '50d':
    case '50n': // névoa
      return Colors.brown.shade200;
    default:
      return Colors.black87;
  }
}
