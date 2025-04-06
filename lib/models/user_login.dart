class UserLogin {
  final String email;
  final String senha;

  UserLogin({required this.email, required this.senha});

  Map<String, dynamic> toJson() => {'email': email, 'senha': senha};
}
