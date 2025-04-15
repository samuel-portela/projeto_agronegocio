import 'package:flutter/material.dart';
import 'package:smart_agro/screens/menu_screen.dart';

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
            leading: Icon(Icons.home),
            title: Text('Ínicio'),
            onTap: () {
              Navigator.of(context).pushNamed('/menuScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmar saída'),
                    content: Text('Tem certeza que deseja sair? Será necessário efetuar o login novamente.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o dialog
                        },
                      ),
                      TextButton(
                        child: Text('Sair'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o dialog
                          Navigator.of(context).pop(); // Fecha o Drawer
                          Navigator.pushNamed(context,'/');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
