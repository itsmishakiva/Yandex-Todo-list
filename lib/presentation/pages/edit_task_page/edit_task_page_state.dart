import '../../../domain/task_model.dart';

class EditTaskPageState {
  EditTaskPageState(
    this.task, {
    this.importanceValue,
  });

  TaskModel task;
  String? importanceValue;

  EditTaskPageState copyWith({TaskModel? task, String? importanceValue}) {
    return EditTaskPageState(
      task ?? this.task,
      importanceValue: importanceValue ?? this.importanceValue,
    );
  }
}
