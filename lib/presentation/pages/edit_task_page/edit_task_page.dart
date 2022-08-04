import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/presentation/navigation/navigation_controller.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/delete_button.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/save_button.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/task_text_field.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/task_model.dart';
import '../widgets/date_text.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  String importanceValue = '';
  final TextEditingController _textController = TextEditingController();
  TaskModel? task = TaskModel(
    id: const Uuid().v1(),
    text: '',
    done: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      importanceValue = AppLocalizations.of(context)!.no;
      if (ModalRoute.of(context)?.settings.arguments != null) {
        task = ModalRoute.of(context)?.settings.arguments as TaskModel;
        _textController.text = task!.text;
      }
      switch (task!.importance) {
        case 'important':
          {
            importanceValue = AppLocalizations.of(context)!.high;
            break;
          }
        case 'low':
          {
            importanceValue = AppLocalizations.of(context)!.low;
            break;
          }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  context.read<NavigationController>().pop();
                },
                splashRadius: 20,
                icon: SvgPicture.asset(
                  'assets/close.svg',
                  width: 24,
                ),
              ),
              actions: [SaveButton(task: task)],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskTextField(textController: _textController, task: task),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: PopupMenuButton<String>(
                      tooltip: '',
                      itemBuilder: (context) {
                        return [
                          AppLocalizations.of(context)!.no,
                          AppLocalizations.of(context)!.low,
                          AppLocalizations.of(context)!.high,
                        ]
                            .map(
                              (value) => PopupMenuItem<String>(
                                value: value,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: SizedBox(
                                  width: 132,
                                  height: 48,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value,
                                      style: value ==
                                              AppLocalizations.of(context)!.high
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline5
                                          : Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList();
                      },
                      offset: const Offset(8, 0),
                      onSelected: (value) {
                        if (value == AppLocalizations.of(context)!.low) {
                          task!.importance = 'low';
                        } else if (value ==
                            AppLocalizations.of(context)!.high) {
                          task!.importance = 'important';
                        } else {
                          task!.importance = 'basic';
                        }
                        setState(() {
                          importanceValue = value;
                        });
                      },
                      initialValue: importanceValue,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.importance,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                importanceValue,
                                style: importanceValue ==
                                        AppLocalizations.of(context)!.high
                                    ? Theme.of(context).textTheme.headline5
                                    : Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 32,
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.do_until,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(height: 4),
                              if (task!.deadline != null)
                                DateText(
                                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                                    100 * task!.deadline!,
                                  ),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 20,
                            child: Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: task!.deadline != null,
                              onChanged: (value) async {
                                if (value == false) {
                                  task!.deadline = null;
                                  setState(() {});
                                  return;
                                }
                                int? chosenDate = (await showDatePicker(
                                  context: context,
                                  initialDate: task!.deadline == null
                                      ? DateTime.now()
                                      : DateTime.fromMillisecondsSinceEpoch(
                                          task!.deadline! * 100),
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime(2070),
                                ))
                                    ?.millisecondsSinceEpoch;
                                task!.deadline = chosenDate == null
                                    ? null
                                    : chosenDate ~/ 100;
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    height: 16,
                  ),
                  DeleteButton(task: task),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
