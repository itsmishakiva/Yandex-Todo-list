import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/presentation/constants/project_theme_data.dart';
import 'package:todo_list/presentation/navigation/router_delegate.dart';
import 'package:todo_list/presentation/navigation/task_route_information_parser.dart';
import 'package:todo_list/presentation/pages/edit_task_page/edit_task_page.dart';
import 'package:todo_list/presentation/pages/tasks_page/tasks_page.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? color = ref.watch(remoteConfigProvider).asData?.value.getInt('color');

    return MaterialApp.router(
      routerDelegate: ref.watch(navigationProvider1),
      routeInformationParser: TaskRouteInformationParser(),
      theme: ProjectThemeData.getTheme(
          importanceColor: color != null && color >= 0 ? Color(color) : null),
      /*navigatorKey: ref.read(navigationProvider).key,
      routes: {
        '/tasks': (context) => const TasksPage(),
        '/edit_tasks': (context) => EditTaskPage(),
      },
      initialRoute: '/tasks',*/
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
      ],
    );
  }
}
