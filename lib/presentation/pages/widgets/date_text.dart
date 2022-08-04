import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateText extends StatelessWidget {
  const DateText({Key? key, required this.dateTime, this.style}) : super(key: key);

  final DateTime dateTime;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    String? monthName;

    switch (dateTime.month) {
      case 1:
        {
          monthName = AppLocalizations.of(context)!.jan;
          break;
        }
      case 2:
        {
          monthName = AppLocalizations.of(context)!.feb;
          break;
        }
      case 3:
        {
          monthName = AppLocalizations.of(context)!.mar;
          break;
        }
      case 4:
        {
          monthName = AppLocalizations.of(context)!.apr;
          break;
        }
      case 5:
        {
          monthName = AppLocalizations.of(context)!.may;
          break;
        }
      case 6:
        {
          monthName = AppLocalizations.of(context)!.jun;
          break;
        }
      case 7:
        {
          monthName = AppLocalizations.of(context)!.jul;
          break;
        }
      case 8:
        {
          monthName = AppLocalizations.of(context)!.aug;
          break;
        }
      case 9:
        {
          monthName = AppLocalizations.of(context)!.sep;
          break;
        }
      case 10:
        {
          monthName = AppLocalizations.of(context)!.okt;
          break;
        }
      case 11:
        {
          monthName = AppLocalizations.of(context)!.nov;
          break;
        }
      case 12:
        {
          monthName = AppLocalizations.of(context)!.dec;
          break;
        }
    }
    return Text(
      '${dateTime.day} $monthName ${dateTime.year}',
      style: style ?? Theme.of(context).textTheme.headline3,
    );
  }
}
