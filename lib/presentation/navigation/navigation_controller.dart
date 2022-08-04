import 'package:flutter/cupertino.dart';

class NavigationController {
  final GlobalKey<NavigatorState> _key = GlobalKey();

  GlobalKey<NavigatorState> get key => _key;

  void navigateTo (String routeName, {Object? arguments}) {
    _key.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    return _key.currentState?.pop();
  }

}