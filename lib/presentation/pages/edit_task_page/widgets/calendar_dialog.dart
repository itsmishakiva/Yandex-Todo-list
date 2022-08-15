import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/presentation/pages/edit_task_page/widgets/calendar_header_text.dart';

import '../../../../domain/task_model.dart';
import '../../../navigation/navigation_controller.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key, required this.task}) : super(key: key);

  final TaskModel task;

  @override
  CalendarDialogState createState() => CalendarDialogState();
}

class CalendarDialogState extends State<CalendarDialog> {
  late DateTime chosenDate;

  @override
  void initState() {
    super.initState();
    chosenDate = (widget.task.deadline == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(widget.task.deadline! * 100));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.height * 0.12,
      ),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return ListOrColumn(
            children: [
              Container(
                height: 96,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 14.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chosenDate.year.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(height: 7),
                      CalendarHeaderText(
                        date: chosenDate,
                      ),
                    ],
                  ),
                ),
              ),
              TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                focusedDay: chosenDate,
                firstDay: DateTime(1970),
                lastDay: DateTime(2070),
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 12,
                          height: 20 / 12,
                        ),
                    weekendStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 12,
                          height: 20 / 12,
                        ),
                    dowTextFormatter: (dateTime, locale) {
                      switch (dateTime.weekday) {
                        case 7:
                          {
                            return AppLocalizations.of(context)!.sun;
                          }
                        case 1:
                          {
                            return AppLocalizations.of(context)!.mon;
                          }
                        case 2:
                          {
                            return AppLocalizations.of(context)!.tue;
                          }
                        case 3:
                          {
                            return AppLocalizations.of(context)!.wed;
                          }
                        case 4:
                          {
                            return AppLocalizations.of(context)!.thu;
                          }
                        case 5:
                          {
                            return AppLocalizations.of(context)!.fri;
                          }
                        default:
                          {
                            return AppLocalizations.of(context)!.sat;
                          }
                      }
                    }),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    formatButtonPadding: EdgeInsets.zero,
                    titleTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    titleCentered: true,
                    titleTextFormatter: (dateTime, locale) {
                      switch (dateTime.month) {
                        case 1:
                          {
                            return '${AppLocalizations.of(context)!.january} ${dateTime.year}';
                          }
                        case 2:
                          {
                            return '${AppLocalizations.of(context)!.february}  ${dateTime.year}';
                          }
                        case 3:
                          {
                            return '${AppLocalizations.of(context)!.march}  ${dateTime.year}';
                          }
                        case 4:
                          {
                            return '${AppLocalizations.of(context)!.april}  ${dateTime.year}';
                          }
                        case 5:
                          {
                            return '${AppLocalizations.of(context)!.may_im}  ${dateTime.year}';
                          }
                        case 6:
                          {
                            return '${AppLocalizations.of(context)!.june}  ${dateTime.year}';
                          }
                        case 7:
                          {
                            return '${AppLocalizations.of(context)!.july}  ${dateTime.year}';
                          }
                        case 8:
                          {
                            return '${AppLocalizations.of(context)!.august}  ${dateTime.year}';
                          }
                        case 9:
                          {
                            return '${AppLocalizations.of(context)!.september}  ${dateTime.year}';
                          }
                        case 10:
                          {
                            return '${AppLocalizations.of(context)!.october}  ${dateTime.year}';
                          }
                        case 11:
                          {
                            return '${AppLocalizations.of(context)!.november}  ${dateTime.year}';
                          }
                        default:
                          {
                            return '${AppLocalizations.of(context)!.december}  ${dateTime.year}';
                          }
                      }
                    }),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  holidayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: Theme.of(context).textTheme.caption!,
                  defaultTextStyle: Theme.of(context).textTheme.caption!,
                  holidayTextStyle: Theme.of(context).textTheme.caption!,
                  todayTextStyle: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  selectedTextStyle: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(chosenDate, day);
                },
                onDaySelected: (oldDay, newDay) {
                  setState(() {
                    chosenDate = newDay;
                  });
                },
              ),
              if (orientation == Orientation.portrait)
                const Spacer(),
              if (orientation == Orientation.landscape)
                const SizedBox(height: 16.0),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.read<NavigationController>().pop();
                      },
                      child: const Text('ОТМЕНА'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        context.read<NavigationController>().pop(chosenDate);
                      },
                      child: const Text('ГОТОВО'),
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}

class ListOrColumn extends StatelessWidget {
  const ListOrColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            children: children,
          );
        }
        return ListView(
          children: children,
        );
      },
    );
  }
}
