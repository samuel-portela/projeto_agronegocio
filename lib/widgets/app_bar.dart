import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const AppBarWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green[700],
      centerTitle: true,

      // Ícone do menu na esquerda
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.maybeOf(context)?.openDrawer();
        },
      ),

      // Imagem centralizada no title
      title: Image.asset('assets/images/logoAndText.png', height: 58),

      // Avatar no lado esquerdo junto com o menu (via actions com Spacer)
      actions: [
        // Trick para empurrar o avatar para a esquerda com espaço à direita
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
