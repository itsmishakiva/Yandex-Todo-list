import 'package:flutter_riverpod/flutter_riverpod.dart';

var tasksPageProvider = StateNotifierProvider<TasksPageController, bool>(
    (ref) => TasksPageController());

class TasksPageController extends StateNotifier<bool> {
  TasksPageController() : super(true);

  void changeDoneVisibility(bool value) {
    state = value;
  }
}
