import '../../../domain/task_model.dart';

class EditTaskPageState {
  EditTaskPageState(
    this.task, {
    this.importanceValue,
  });

  TaskModel task;
  String? importanceValue;
}
