import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/task_model.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
    required TextEditingController textController,
    required this.task,
  }) : _textController = textController, super(key: key);

  final TextEditingController _textController;
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _textController,
              maxLines: null,
              minLines: 4,
              onChanged: (value) {
                task!.text = value;
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.needToDo,
                isDense: true,
                filled: true,
                fillColor: Theme.of(context).primaryColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}