import 'package:flutter/material.dart';
import 'package:poke_app/src/controllers/menu_controller.dart';
import 'package:provider/provider.dart';

class SideTile extends StatelessWidget {
  const SideTile({
    required this.title,
    required this.page,
  });

  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<MenuControllerBase>().page;
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 10),
      child: GestureDetector(
        onTap: (){
          context.read<MenuControllerBase>().setPage(page);
        },
        child: Text(
          title,
          style: curPage == page ? TextStyle(
              color: Colors.deepPurple,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ) : TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500
          )
        ),
      ),
    );
  }
}