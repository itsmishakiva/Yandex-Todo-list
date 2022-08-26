import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/domain/task_model.dart';
import 'package:todo_list/presentation/pages/edit_task_page/edit_task_controller.dart';
import 'package:todo_list/presentation/pages/tasks_page/tasks_page_controller.dart';

void main() {
  group("Edit task page controller", () {
    test('Clear data test', () {
      EditTaskController controller = EditTaskController();
      var state = controller.debugState.copyWith();
      TaskModel task = TaskModel(
          id: 'test_id',
          text: 'new_text',
          done: false,
          importance: 'important');
      controller.updateTask(task);
      controller.changeImportanceValue('basic');
      controller.clearData();
      expect(
        [
          state.importanceValue,
          state.task.copyWith(id: 'test'),
        ],
        [
          controller.debugState.importanceValue,
          controller.debugState.task.copyWith(id: 'test'),
        ],
      );
    });
    test('Update task', () {
      EditTaskController controller = EditTaskController();
      TaskModel task = TaskModel(
          id: 'test_id',
          text: 'new_text',
          done: false,
          importance: 'important');
      controller.updateTask(task);
      expect(task, controller.debugState.task);
    });
    test('Change importance value', () {
      EditTaskController controller = EditTaskController();
      controller.changeImportanceValue('important');
      expect('important', controller.debugState.importanceValue);
    });
  });
  group("Tasks page controller", () {
    test('Change visibility', () {
      TasksPageController controller = TasksPageController();
      controller.changeDoneVisibility(false);
      expect(false, controller.debugState);
    });
  });
}
