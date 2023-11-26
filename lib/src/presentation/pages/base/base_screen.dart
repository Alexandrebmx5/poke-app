import 'package:flutter/material.dart';
import 'package:poke_app/src/controllers/menu_controller.dart';
import 'package:poke_app/src/presentation/pages/home/home_screen.dart';
import 'package:poke_app/src/presentation/pages/types/types_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MenuControllerBase(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          TypesScreen(),
        ],
      ),
    );
  }
}