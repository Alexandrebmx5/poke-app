import 'package:flutter/material.dart';

class MenuControllerBase {

  MenuControllerBase(this._menuController);

  final PageController _menuController;

  int page = 0;

  void setPage(int value) {
    if (value == page) return;
    page = value;
    _menuController.jumpToPage(value);
  }
}