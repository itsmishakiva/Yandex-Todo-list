import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/presentation/navigation/navigation_controller.dart';

import '../../../../domain/task_model.dart';
import '../../widgets/date_text.dart';

class DismissibleTask extends StatefulWidget {
  const DismissibleTask({
    Key? key,
    required this.task,
    required this.onCheckBoxChanged,
    required this.onDelete,
    required this.onMarkedDone, this.shadows,
  }) : super(key: key);

  final TaskModel task;
  final void Function(bool?) onCheckBoxChanged;
  final void Function() onDelete;
  final void Function() onMarkedDone;
  final List<BoxShadow>? shadows;

  @override
  State<DismissibleTask> createState() => _DismissibleTaskState();
}

class _DismissibleTaskState extends State<DismissibleTask>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        upperBound: 1,
        lowerBound: -1,
        duration: Duration.zero,
        value: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          widget.onMarkedDone();
          return false;
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          widget.onDelete();
        }
      },
      onUpdate: (details) {
        if (details.direction == DismissDirection.endToStart) {
          _animationController.animateTo(-details.progress);
        } else {
          _animationController.animateTo(details.progress);
        }
      },
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    _animationController.value *
                                MediaQuery.of(context).size.width <
                            72
                        ? 0
                        : _animationController.value *
                                MediaQuery.of(context).size.width -
                            72,
                    0),
                child: child!,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.error,
        child: Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    _animationController.value *
                        MediaQuery.of(context).size.width >
                        -72
                        ? 0
                        : _animationController.value *
                        MediaQuery.of(context).size.width +
                        72,
                    0),
                child: child!,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SvgPicture.asset('assets/delete.svg', color: Colors.white,)
            ),
          ),
        ),
      ),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            widget.onCheckBoxChanged(null);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: widget.task.importance == 'important'
                          ? Theme.of(context).colorScheme.onSecondary
                          : null,
                      child: Checkbox(
                        value: widget.task.done,
                        side: widget.task.importance == 'important'
                            ? BorderSide(
                                color: Theme.of(context).colorScheme.error,
                                width: 2,
                              )
                            : null,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        splashRadius: 20,
                        onChanged: (value) {
                          widget.onCheckBoxChanged(value);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (widget.task.importance != 'basic')
                  widget.task.importance == 'low'
                      ? SvgPicture.asset(
                          'assets/arrow_down.svg',
                          color: Theme.of(context).primaryIconTheme.color,
                        )
                      : SvgPicture.asset(
                          'assets/important.svg',
                          color: Theme.of(context).colorScheme.error,
                        ),
                if (widget.task.importance != 'basic') const SizedBox(width: 3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.text.replaceAll('\n', ' '),
                        style: widget.task.done
                            ? Theme.of(context).textTheme.bodyText2
                            : Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                      ),
                      if (widget.task.deadline != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DateText(
                            dateTime: DateTime.fromMillisecondsSinceEpoch(
                                widget.task.deadline! * 100),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Consumer(
                  builder: (context, ref, child) {
                    return IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 20.0,
                      iconSize: 24.0,
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      onPressed: () {
                        print(widget.task);
                        ref.read(navigationProvider).navigateToEditPage(arguments: TaskModel.copy(task: widget.task));
                      },
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
