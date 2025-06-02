import 'package:flutter/material.dart';

class Menucontroller extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addProductScaffoldKey =
      GlobalKey<ScaffoldState>();

  //getters
  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getgridscaffoldKey => _gridScaffoldKey;
  GlobalKey<ScaffoldState> get getAddProductscaffoldKey =>
      _addProductScaffoldKey;

  //callbacks
  void controlDashboardMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controlProductsMenu() {
    if (!_gridScaffoldKey.currentState!.isDrawerOpen) {
      _gridScaffoldKey.currentState!.openDrawer();
    }
  }

  void controlAddProductsMenu() {
    if (!_addProductScaffoldKey.currentState!.isDrawerOpen) {
      _addProductScaffoldKey.currentState!.openDrawer();
    }
  }
}
