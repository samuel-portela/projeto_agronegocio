import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:smart_agro/controllers/login_controller.dart';
import 'package:smart_agro/models/user_login.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('[Caixa-Preta] Deve retornar true com login válido', () async {
    final controller = LoginController();

    final user = UserLogin(email: 'samuel@hotmail.com', senha: '123456');

    final result = await controller.login(user);

    expect(result, true);
  });

  test('[Caixa-Branca] Deve retornar true com login válido', () async {
    final controller = LoginController();
    final user = UserLogin(email: 'samuel@hotmail.com', senha: '123456');

    final result = await controller.login(user);

    expect(result, true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    expect(token, isNotNull);
  });

    test('[Caixa-Cinza] Deve retornar true com login válido', () async {
    final controller = LoginController();
    
    final user = UserLogin(email: 'samuel@hotmail.com', senha: '123456');
    
    final result = await controller.login(user);

    expect(result, true); 
  });
}
