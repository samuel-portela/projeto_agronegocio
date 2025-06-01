import 'dart:convert';
import 'package:http/http.dart' as http;

class DadosController {
  final String apiUrl = 'http://3.82.212.170:4040/preencher-dados';

  Future<bool> enviarFormularioMultiplo({
    required List<Map<String, dynamic>> fazendas,
    required String token,
  }) async {
    for (var fazenda in fazendas) {
      final sucesso = await enviarFormulario(
        nome: fazenda['nome'],
        tipoPlantacao: List<String>.from(fazenda['plantacoes']),
        token: token,
      );

      if (!sucesso) {
        return false; // Para o envio se uma das fazendas falhar
      }
    }
    return true;
  }

  Future<bool> enviarFormulario({
    required String nome,
    required List<String> tipoPlantacao,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'tipo_plantacao': tipoPlantacao.join(', '),
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Erro: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro de conexão: $e');
      return false;
    }
  }
}
