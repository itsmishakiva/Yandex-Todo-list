import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/presentation/pages/tasks_page/tasks_page_controller.dart';
import 'package:todo_list/presentation/pages/tasks_page/widgets/custom_flexible_space.dart';
import 'package:todo_list/presentation/pages/tasks_page/widgets/dismissible_task.dart';
import 'package:todo_list/presentation/pages/widgets/custom_scaffold.dart';

import '../../../data/reposiroty/data_repository.dart';
import '../../../domain/task_model.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  int getDoneCount(List<TaskModel> tasks) {
    int value = 0;
    for (var task in tasks) {
      if (task.done) value++;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Banner(
      location: BannerLocation.topEnd,
      message: 'DEV',
      color: Color(0xC45F236F),
      child: CustomScaffold(
        body: SafeArea(
          top: false,
          child: Consumer(
            builder: (context, ref, child) {
              return StreamBuilder<List<TaskModel>>(
                stream: ref.watch(dataProvider).getAllTasksStream(),
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
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: SchedulerBinding
                                      .instance.window.platformBrightness ==
                                  Brightness.light
                              ? Brightness.dark
                              : Brightness.light,
                          statusBarBrightness: SchedulerBinding
                                      .instance.window.platformBrightness ==
                                  Brightness.light
                              ? Brightness.light
                              : Brightness.dark,
                        ),
                        flexibleSpace: CustomFlexibleSpace(
                          doneTasksCount: getDoneCount(snapshot.data!),
                          expandedHeight: 146,
                          action: SizedBox(
                            height: 24,
                            width: 24,
                            child: Consumer(
                              builder: (context, ref, child) {
                                bool value = ref.watch(tasksPageProvider);
                                return IconButton(
                                  padding: EdgeInsets.zero,
                                  splashRadius: 20,
                                  iconSize: 24,
                                  icon: SvgPicture.asset(
                                    value
                                        ? 'assets/visibility.svg'
                                        : 'assets/visibility_off.svg',
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(tasksPageProvider.notifier)
                                        .changeDoneVisibility(!value);
                                  },
                                );
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
                                  bottom:
                                      index == snapshot.data!.length ? 8.0 : 0),
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
                              child: Column(
                                children: [
                                  if (index == 0)
                                    Container(
                                      height: 8,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  index == snapshot.data!.length
                                      ? Material(
                                          color: Theme.of(context).primaryColor,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Consumer(
                                              builder: (context, ref, child) {
                                                return InkWell(
                                                    onTap: () {
                                                      ref
                                                          .read(
                                                              navigationProvider)
                                                          .navigateToEditPage();
                                                    },
                                                    child: child!);
                                              },
                                              child: SizedBox(
                                                height: 48,
                                                width: double.infinity,
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
                                      : Consumer(
                                          builder: (context, ref, child) {
                                            if (ref.watch(tasksPageProvider) ||
                                                !snapshot.data![index].done) {
                                              return DismissibleTask(
                                                shadows: [
                                                  if (index != 0)
                                                    BoxShadow(
                                                      offset: const Offset(0, 0),
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                      blurRadius: 2.0,
                                                    ),
                                                ],
                                                task: snapshot.data![index],
                                                onDelete: () async {
                                                  var task =
                                                      snapshot.data![index];
                                                  snapshot.data!.removeAt(index);
                                                  ref
                                                      .read(dataProvider.notifier)
                                                      .removeTask(task);
                                                },
                                                onMarkedDone: () async {
                                                  snapshot.data![index] = snapshot
                                                      .data![index]
                                                      .copyWith(
                                                    done: true,
                                                  );
                                                  ref
                                                      .read(dataProvider)
                                                      .updateTask(
                                                          snapshot.data![index]);
                                                },
                                                onCheckBoxChanged: (value) async {
                                                  snapshot.data![index] = snapshot
                                                      .data![index]
                                                      .copyWith(
                                                    done: !snapshot
                                                        .data![index].done,
                                                  );
                                                  ref
                                                      .read(dataProvider)
                                                      .updateTask(
                                                          snapshot.data![index]);
                                                },
                                              );
                                            }
                                            return child!;
                                          },
                                          child: const SizedBox(),
                                        ),
                                ],
                              ),
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
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            return FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 6,
              onPressed: () {
                ref.read(navigationProvider).navigateToEditPage();
              },
              child: child,
            );
          },
          child: SvgPicture.asset(
            'assets/add.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
