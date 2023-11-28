import 'package:flutter/material.dart';
import 'package:poke_app/src/presentation/drawer/side_tile.dart';

class SideMenu extends StatefulWidget {

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 15, right: 15, bottom: 30),
            child: Text('Bem-vindo ao Poke App', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SideTile(
            title: 'Home',
            page: 0,
          ),
          SideTile(
            title: 'Tipos de pokemon',
            page: 1,
          ),
          SideTile(
            title: 'Favoritos',
            page: 2,
          )
        ],
      ),
    );
  }
}