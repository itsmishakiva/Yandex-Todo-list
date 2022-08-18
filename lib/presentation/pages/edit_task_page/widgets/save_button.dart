import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/domain/task_model.dart';
import 'package:todo_list/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/reposiroty/data_repository.dart';
import '../edit_task_controller.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            const Size(100, 40),
          ),
        ),
        onPressed: () {
          task!.updatedAt =
              DateTime.now().millisecondsSinceEpoch ~/ 100;
          if (task!.text.isNotEmpty && task!.text.trim().isNotEmpty) {
            if (task!.createdAt == null) {
              task!.createdAt =
                  DateTime.now().millisecondsSinceEpoch ~/ 100;
              ref.read(dataProvider).insertTask(task!);
            } else {
              ref.read(dataProvider).updateTask(task!);
            }
            ref.read(editPageProvider.notifier).clearData();
            ref.read(navigationProvider).pop();
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.empty_name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.save,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}