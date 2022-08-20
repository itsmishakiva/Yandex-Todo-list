import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/presentation/navigation/task_route_path.dart';
import 'package:todo_list/presentation/pages/edit_task_page/edit_task_page.dart';
import 'package:todo_list/presentation/pages/not_found_page/not_found_page.dart';

import '../../domain/task_model.dart';
import '../pages/tasks_page/tasks_page.dart';

class TasksRouterDelegate extends RouterDelegate<TaskRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<TaskRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedTaskId;
  bool show404 = false;
  bool newTask = false;

  TasksRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    print('id: $_selectedTaskId 404: $show404 new: $newTask');
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          key: ValueKey('TasksListPage'),
          child: TasksPage(),
        ),
        if (show404)
          const MaterialPage(
            key: ValueKey('UnknownPage'),
            child: NotFoundPage(),
          )
        else if (newTask)
          const MaterialPage(
            key: ValueKey('EditTaskPage'),
            child: EditTaskPage(),
          )
        else if (_selectedTaskId != null)
          MaterialPage(
            key: const ValueKey('EditTaskPage'),
            child: EditTaskPage(
              taskId: _selectedTaskId,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _selectedTaskId = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(TaskRoutePath configuration) async {
    print('b');
    if (configuration.unknown) {
      _selectedTaskId = null;
      show404 = true;
      return;
    }

    if (configuration.isTaskPage) {
      newTask = configuration.newTask;
      _selectedTaskId = configuration.taskId;
    } else {
      _selectedTaskId = null;
    }

    show404 = false;
  }

  @override
  TaskRoutePath get currentConfiguration {
    print('a');
    if (show404) {
      return TaskRoutePath.unknown();
    }

    if (newTask) {
      return TaskRoutePath.task();
    }

    return _selectedTaskId == null
        ? TaskRoutePath.home()
        : TaskRoutePath.task(taskId: _selectedTaskId);
  }

  void handleTaskTapped(String? taskId) {
    print('f');
    _selectedTaskId = taskId;
    if (taskId == null) newTask = true;
    notifyListeners();
  }

  void goToHome() {
    _selectedTaskId = null;
    newTask = false;
    show404 = false;
    notifyListeners();
  }
}
