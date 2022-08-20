import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/main.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/task_model.dart';
import 'edit_task_page_state.dart';

var editPageProvider =
    StateNotifierProvider<EditTaskController, EditTaskPageState>(
  (ref) => EditTaskController(ref),
);

class EditTaskController extends StateNotifier<EditTaskPageState> {
  EditTaskController(this.ref)
      : super(
          EditTaskPageState(
            TaskModel(
              id: const Uuid().v1(),
              text: '',
              done: false,
            ),
          ),
        );

  final Ref ref;

  void initData(
      {required TaskModel task,
      required String important,
      required String basic,
      required String low}) {
    if (task != state.task) {
      String importanceValue = basic;
      switch (task.importance) {
        case 'important':
          {
            importanceValue = important;
            break;
          }
        case 'low':
          {
            importanceValue = low;
            break;
          }
        default:
          {
            importanceValue = basic;
            break;
          }
      }
      state = EditTaskPageState(
        task,
        importanceValue: importanceValue,
      );
    }
  }

  void changeImportanceValue(String newValue) {
    if (state.importanceValue != newValue) {
      state = EditTaskPageState(
        state.task,
        importanceValue: newValue,
      );
    }
  }

  void updateTask(TaskModel task) {
    state = EditTaskPageState(task, importanceValue: state.importanceValue);
  }

  void clearData() {
    state = EditTaskPageState(
      TaskModel(
        id: const Uuid().v1(),
        text: '',
        done: false,
      ),
      importanceValue: null,
    );
  }
}
