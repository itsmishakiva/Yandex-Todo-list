import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/reposiroty/data_repository.dart';
import 'package:todo_list/presentation/navigation/navigation_controller.dart';
import 'package:todo_list/presentation/pages/tasks_page/widgets/custom_flexible_space.dart';
import 'package:todo_list/presentation/pages/tasks_page/widgets/dismissible_task.dart';

import '../../../domain/task_model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool showDoneTasks = true;

  int getDoneCount(List<TaskModel> tasks) {
    int value = 0;
    for (var task in tasks) {
      if (task.done) value++;
    }
    return value;
  }

  void editTask({TaskModel? task}) {
    context.read<NavigationController>().navigateTo('/edit_tasks');
  }

  @override
  Widget build(BuildContext context) {
    context.read<Logger>().fine('test message');
    return Scaffold(
      body: Consumer<DataRepository>(
        builder: (context, data, child) {
          return StreamBuilder<List<TaskModel>>(
            stream: data.getAllTasksStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Icon(Icons.error_outline),
                );
              }
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: true,
                    floating: true,
                    elevation: 4,
                    expandedHeight: 138,
                    backgroundColor: const Color(0xFFF7F6F2),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.light,
                    ),
                    flexibleSpace: CustomFlexibleSpace(
                      doneTasksCount: getDoneCount(snapshot.data!),
                      expandedHeight: 146,
                      action: SizedBox(
                        height: 24,
                        width: 24,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                          iconSize: 24,
                          icon: SvgPicture.asset(
                            showDoneTasks
                                ? 'assets/visibility.svg'
                                : 'assets/visibility_off.svg',
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            setState(() {
                              showDoneTasks = !showDoneTasks;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: index == 0 ? 8.0 : 0,
                              bottom: index == snapshot.data!.length ? 8.0 : 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: index == 0
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                              topLeft: index == 0
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                              bottomRight: index == snapshot.data!.length
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                              bottomLeft: index == snapshot.data!.length
                                  ? const Radius.circular(8)
                                  : const Radius.circular(0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                color: Theme.of(context).shadowColor,
                                blurRadius: 2.0,
                              ),
                              if (index == 0)
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  color: Theme.of(context).primaryColorDark,
                                  blurRadius: 2.0,
                                ),
                            ],
                          ),
                          child: index == snapshot.data!.length
                              ? Material(
                                  color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        editTask();
                                      },
                                      child: SizedBox(
                                        height: 48,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 14.0,
                                            right: 16.0,
                                            left: 52.0,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .newTask,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : !snapshot.data![index].done || showDoneTasks
                                  ? Column(
                                      children: [
                                        if (index == 0)
                                          Container(
                                            height: 8,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        DismissibleTask(
                                          shadows: [
                                            if (index != 0)
                                            BoxShadow(
                                              offset: const Offset(0, 0),
                                              color: Theme.of(context).primaryColorDark,
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                          task: snapshot.data![index],
                                          onDelete: () async {
                                            var task = snapshot.data![index];
                                            snapshot.data!.removeAt(index);
                                            data.removeTask(task);
                                          },
                                          onMarkedDone: () async {
                                            snapshot.data![index].done = true;
                                            data.updateTask(
                                                snapshot.data![index]);
                                          },
                                          onCheckBoxChanged: (value) async {
                                            snapshot.data![index].done =
                                                !snapshot.data![index].done;
                                            data.updateTask(
                                                snapshot.data![index]);
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                        );
                      },
                      childCount: snapshot.data!.length + 1,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 6,
        onPressed: () {
          editTask();
        },
        child: SvgPicture.asset(
          'assets/add.svg',
          color: Colors.white,
        ),
      ),
    );
  }
}
