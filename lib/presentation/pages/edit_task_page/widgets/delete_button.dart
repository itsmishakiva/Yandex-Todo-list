import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/main.dart';

import '../../../../data/reposiroty/data_repository.dart';
import '../../../../domain/task_model.dart';
import '../edit_task_controller.dart';

class DeleteButton extends ConsumerWidget {
  const DeleteButton({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 48.0,
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(8.0),
            ),
            overlayColor: MaterialStateProperty.all(
              task!.createdAt == null
                  ? Colors.transparent
                  : Theme.of(context).hoverColor,
            ),
          ),
          onPressed: () {
            if (task!.createdAt != null) {
              ref.read(dataProvider).removeTask(task!);
              ref.read(editPageProvider.notifier).clearData();
              ref.read(navigationProvider).pop();
            }
          },
          child: Opacity(
            opacity: task!.createdAt == null ? 0.15 : 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/delete.svg',
                  width: 24,
                  color: task!.createdAt == null
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: task!.createdAt == null
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
