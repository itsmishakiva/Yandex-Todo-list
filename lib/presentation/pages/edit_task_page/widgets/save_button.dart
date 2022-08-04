import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/db_client.dart';
import 'package:todo_list/domain/task_model.dart';

import '../../../navigation/navigation_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
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
          if (task!.text.isNotEmpty) {
            if (task!.createdAt == null) {
              task!.createdAt =
                  DateTime.now().millisecondsSinceEpoch ~/ 100;
              context.read<DBClient>().insertTask(task!);
            } else {
              context.read<DBClient>().updateTask(task!);
            }
            context.read<NavigationController>().pop();
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Text(
                    'Empty name!',
                    style: Theme.of(context).textTheme.headline1,
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