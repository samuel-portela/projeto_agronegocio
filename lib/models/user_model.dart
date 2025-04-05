class UserModel {
  final String nome;
  final String email;
  final String senha;
  final String telefone;

  UserModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.telefone,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'email': email,
    'senha': senha,
    'telefone': telefone,
  };
}
