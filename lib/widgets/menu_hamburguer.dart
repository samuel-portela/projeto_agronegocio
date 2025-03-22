import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final String nome;
  final String email;

  // Construtor
  DrawerWidget({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Cabeçalho do Drawer
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            accountName: Text(nome),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                nome.isNotEmpty
                    ? nome[0].toUpperCase()
                    : '', // Primeira letra do nome
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Navegação para Configurações
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              // Navegação para Perfil
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              // Implementar logout aqui se necessário
            },
          ),
        ],
      ),
    );
  }
}
