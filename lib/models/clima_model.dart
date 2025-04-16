class ClimaModel {
  final String cidade;
  final String descricao;
  final double temperatura;
  final double umidade;
  final String icone;

  ClimaModel({
    required this.cidade,
    required this.descricao,
    required this.temperatura,
    required this.umidade,
    required this.icone,
  });

  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      cidade: json['name'],
      descricao: json['weather'][0]['description'],
      temperatura: (json['main']['temp'] as num).toDouble(),
      umidade: (json['main']['humidity'] as num).toDouble(),
      icone: json['weather'][0]['icon'],
    );
  }
}
