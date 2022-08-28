import 'package:flutter/cupertino.dart';

class NavigationController {
  final GlobalKey<NavigatorState> _key = GlobalKey();

  GlobalKey<NavigatorState> get key => _key;

  void navigateTo(String routeName, {Object? arguments}) {
    _key.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void navigateToTasksPage({Object? arguments}) {
    _key.currentState?.pushNamed('/edit_tasks', arguments: arguments);
  }

  void pop([dynamic result]) {
    return _key.currentState?.pop(result);
  }
}
