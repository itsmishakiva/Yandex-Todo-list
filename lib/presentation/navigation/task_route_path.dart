class TaskRoutePath {
  final String? taskId;
  final bool unknown;
  final bool newTask;

  TaskRoutePath.home()
      : taskId = null,
        unknown = false,
        newTask = false;

  TaskRoutePath.task({this.taskId})
      : unknown = false,
        newTask = taskId == null ? true : false;

  TaskRoutePath.unknown()
      : newTask = false,
        taskId = null,
        unknown = true;

  bool get isHomePage => taskId == null && newTask == false;

  bool get isTaskPage => taskId != null || newTask == true;

  bool get isUnknown => unknown == true;
}
