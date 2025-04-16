import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_agro/models/clima_model.dart';
import '../models/clima_model.dart';

class ClimaController {
  final String _apiKey = 'ab098a13f7061244602775ca9d99feff';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<ClimaModel> buscarClimaAtual({String cidade = 'São Paulo'}) async {
    final uri = Uri.parse('$_baseUrl?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ClimaModel.fromJson(data);
    } else {
      throw Exception('Erro ao buscar clima: ${response.statusCode}');
    }
  }
}
