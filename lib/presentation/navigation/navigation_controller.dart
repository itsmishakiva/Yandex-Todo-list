import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/main.dart';

import '../../domain/task_model.dart';

class NavigationController {
  final GlobalKey<NavigatorState> _key = GlobalKey();

  GlobalKey<NavigatorState> get key => _key;

  NavigationController(this.ref);

  Ref ref;

  void navigateToEditPage({TaskModel? task}) {
    ref.read(analyticsProvider).logEvent(name: 'Navigated to edit page');
    ref.read(navigationProvider1).handleTaskTapped(task?.id);
  }

  void pop() {
    ref.read(analyticsProvider).logEvent(name: 'Page closed');
    ref.read(navigationProvider1).goToHome();
  }

}