import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarHeaderText extends StatelessWidget {
  const CalendarHeaderText({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    String text = '';
    switch (date.weekday) {
      case 7:
        {
          text += '${AppLocalizations.of(context)!.sun}, ';
          break;
        }
      case 1:
        {
          text += '${AppLocalizations.of(context)!.mon}, ';
          break;
        }
      case 2:
        {
          text += '${AppLocalizations.of(context)!.tue}, ';
          break;
        }
      case 3:
        {
          text += '${AppLocalizations.of(context)!.wed}, ';
          break;
        }
      case 4:
        {
          text += '${AppLocalizations.of(context)!.thu}, ';
          break;
        }
      case 5:
        {
          text += '${AppLocalizations.of(context)!.fri}, ';
          break;
        }
      default:
        {
          text += '${AppLocalizations.of(context)!.sat}, ';
          break;
        }
    }
    switch (date.month) {
      case 1:
        {
          text += '${AppLocalizations.of(context)!.january} ${date.day}';
          break;
        }
      case 2:
        {
          text += '${AppLocalizations.of(context)!.february} ${date.day}';
          break;
        }
      case 3:
        {
          text += '${AppLocalizations.of(context)!.march} ${date.day}';
          break;
        }
      case 4:
        {
          text += '${AppLocalizations.of(context)!.april} ${date.day}';
          break;
        }
      case 5:
        {
          text += '${AppLocalizations.of(context)!.may_im} ${date.day}';
          break;
        }
      case 6:
        {
          text += '${AppLocalizations.of(context)!.june} ${date.day}';
          break;
        }
      case 7:
        {
          text += '${AppLocalizations.of(context)!.july} ${date.day}';
          break;
        }
      case 8:
        {
          text += '${AppLocalizations.of(context)!.august} ${date.day}';
          break;
        }
      case 9:
        {
          text += '${AppLocalizations.of(context)!.september} ${date.day}';
          break;
        }
      case 10:
        {
          text += '${AppLocalizations.of(context)!.october} ${date.day}';
          break;
        }
      case 11:
        {
          text += '${AppLocalizations.of(context)!.november} ${date.day}';
          break;
        }
      case 12:
        {
          text += '${AppLocalizations.of(context)!.december} ${date.day}';
          break;
        }
    }
    return Text(
      text,
      style: Theme.of(context).textTheme.overline,
    );
  }
}
