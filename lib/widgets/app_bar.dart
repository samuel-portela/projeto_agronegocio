import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const AppBarWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green[700],
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.maybeOf(context)?.openDrawer();
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
