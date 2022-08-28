import 'package:flutter/cupertino.dart';
import 'package:todo_list/presentation/navigation/task_route_path.dart';

class TaskRouteInformationParser extends RouteInformationParser<TaskRoutePath> {
  @override
  Future<TaskRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return TaskRoutePath.home();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'task') return TaskRoutePath.unknown();
      return TaskRoutePath.task(taskId: uri.pathSegments[1]);
    }

    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'task') {
      return TaskRoutePath.task();
    }

    return TaskRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(TaskRoutePath configuration) {
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isTaskPage) {
      return RouteInformation(location: '/task/${configuration.taskId}');
    }
    return const RouteInformation(location: '/404');
  }
}
