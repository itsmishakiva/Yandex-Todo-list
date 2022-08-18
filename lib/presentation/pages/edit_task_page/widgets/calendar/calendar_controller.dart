import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarProvider = StateNotifierProvider<CalendarController, DateTime>(
  (ref) => CalendarController(),
);

class CalendarController extends StateNotifier<DateTime> {
  CalendarController() : super(DateTime.now());

  void updateDate(DateTime newDate) {
    state = newDate;
  }

  void clearDate() {
    state = DateTime.now();
  }
}
