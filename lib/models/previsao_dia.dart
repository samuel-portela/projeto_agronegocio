import 'package:intl/intl.dart';

class PrevisaoDia {
  final String descricao;
  final String icone;
  final double temperaturaMin;
  final double temperaturaMax;
  final DateTime data;

  PrevisaoDia({
    required this.descricao,
    required this.icone,
    required this.temperaturaMin,
    required this.temperaturaMax,
    required this.data,
  });

  String get diaFormatado {
    return DateFormat('EEEE dd/MM/yyyy').format(data);  // Exemplo: Segunda-feira 28/04/2024
  }
}
