import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _cidadeKey = 'cidade';

  // Salva a cidade no SharedPreferences
  static Future<void> salvarCidade(String cidade) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cidadeKey, cidade);
  }

  // Recupera a cidade salva
  static Future<String?> obterCidadeSalva() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cidadeKey);
  }

  // Exclui a cidade salva (opcional)
  static Future<void> limparCidade() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cidadeKey);
  }

  // Limpa todos os dados do SharedPreferences (opcional)
  static Future<void> limparTudo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
