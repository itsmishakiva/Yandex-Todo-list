import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);
  final Widget? body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            SchedulerBinding.instance.window.platformBrightness ==
                    Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarBrightness:
            SchedulerBinding.instance.window.platformBrightness ==
                    Brightness.light
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
