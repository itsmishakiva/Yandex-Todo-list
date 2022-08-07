
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFlexibleSpace extends StatelessWidget {
  const CustomFlexibleSpace({
    Key? key,
    required this.expandedHeight,
    required this.action,
    required this.doneTasksCount,
    this.customTitle,
  }) : super(key: key);
  final double expandedHeight;
  final int doneTasksCount;
  final Widget action;
  final String? customTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        if (settings == null) return const SizedBox();
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final translation =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);
        final start = max(0.0, 1.0 - expandedHeight / deltaExtent);
        const end = 1.0;
        final currentValue = 1.0 - Interval(start, end).transform(translation);

        return Padding(
          padding: EdgeInsets.only(
            left: 16 + 44 * currentValue,
            right: 18 + 6 * currentValue,
            bottom: 16 + 10 * currentValue,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    customTitle ?? AppLocalizations.of(context)!.myTasks,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 20 + 12 * currentValue,
                    ),
                  ),
                  SizedBox(height: currentValue * 6),
                  Opacity(
                    opacity: currentValue * 0.3,
                    child: Text(
                      '${AppLocalizations.of(context)!.done_task} — $doneTasksCount',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16 * currentValue,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: action,
              ),
            ],
          ),
        );
      },
    );
  }
}