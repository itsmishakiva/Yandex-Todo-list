import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/data/reposiroty/data_repository.dart';
import 'package:todo_list/providers.dart';
import 'package:todo_list/presentation/pages/edit_task_page/edit_task_controller.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/calendar/calendar_dialog.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/delete_button.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/save_button.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/task_text_field.dart';
import 'package:todo_list/presentation/pages/widgets/custom_scaffold.dart';

import '../../../domain/task_model.dart';
import '../widgets/date_text.dart';

class EditTaskPage extends ConsumerStatefulWidget {
  const EditTaskPage({Key? key, this.taskId}) : super(key: key);
  final String? taskId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditTaskPageState();
}

class EditTaskPageState extends ConsumerState<EditTaskPage> {
  final TextEditingController _textController = TextEditingController();
  bool synced = false;

  void initData(BuildContext context, WidgetRef ref) async {
    TaskModel? args;
    List<TaskModel> tasks =
        await ref.read(dataProvider).getAllTasksStream().last;
    for (var element in tasks) {
      if (widget.taskId == element.id) {
        args = element;
        break;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = ref.read(editPageProvider.notifier);
      var loc = AppLocalizations.of(context)!;
      if (args != null) {
        _textController.text = args.text;
        controller.initData(
          important: loc.high,
          basic: loc.no,
          low: loc.low,
          task: args,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(editPageProvider);
    var controller = ref.read(editPageProvider.notifier);
    if (!synced) {
      synced = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        initData(context, ref);
      });
    }
    return WillPopScope(
      onWillPop: () async {
        ref.read(editPageProvider.notifier).clearData();
        return true;
      },
      child: CustomScaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                  onPressed: () async {
                    ref.read(navigationProvider).pop();
                    controller.clearData();
                  },
                  splashRadius: 20,
                  icon: SvgPicture.asset(
                    'assets/close.svg',
                    width: 24,
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
                actions: [
                  SaveButton(task: state.task),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTextField(
                      textController: _textController,
                      task: state.task,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: PopupMenuButton<String>(
                        color: Theme.of(context).primaryColor,
                        position: PopupMenuPosition.over,
                        offset: Offset(
                          8,
                          state.importanceValue ==
                                  AppLocalizations.of(context)!.high
                              ? 96
                              : (state.importanceValue ==
                                      AppLocalizations.of(context)!.low
                                  ? 48
                                  : 0),
                        ),
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
                                                AppLocalizations.of(context)!
                                                    .high
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
                        onSelected: (value) {
                          if (value == AppLocalizations.of(context)!.low) {
                            state.task = state.task.copyWith(importance: 'low');
                          } else if (value ==
                              AppLocalizations.of(context)!.high) {
                            state.task =
                                state.task.copyWith(importance: 'important');
                          } else {
                            state.task =
                                state.task.copyWith(importance: 'basic');
                          }
                          controller.changeImportanceValue(value);
                        },
                        initialValue: state.importanceValue ??
                            AppLocalizations.of(context)!.no,
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
                                  state.importanceValue ??
                                      AppLocalizations.of(context)!.no,
                                  style: state.importanceValue ==
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
                                if (state.task.deadline != null)
                                  DateText(
                                    dateTime:
                                        DateTime.fromMillisecondsSinceEpoch(
                                      100 * state.task.deadline!,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 20,
                              child: Switch(
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                value: state.task.deadline != null,
                                onChanged: (value) async {
                                  if (value == false) {
                                    state.task =
                                        state.task.copyWith(deadline: null);
                                    controller.updateTask(state.task);
                                    return;
                                  }
                                  int? chosenDate =
                                      (await showDialog<DateTime?>(
                                    context: context,
                                    builder: (context) {
                                      return CalendarDialog(
                                        task: state.task,
                                      );
                                    },
                                  ))
                                          ?.millisecondsSinceEpoch;
                                  state.task = state.task.copyWith(
                                    deadline: chosenDate == null
                                        ? null
                                        : chosenDate ~/ 100,
                                  );
                                  controller.updateTask(state.task);
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
                    DeleteButton(task: state.task),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
