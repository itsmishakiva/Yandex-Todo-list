import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/presentation/constants/project_theme_data.dart';
import 'package:todo_list/presentation/navigation/navigation_controller.dart';
import 'package:todo_list/presentation/pages/edit_task_page/edit_task_page.dart';
import 'package:todo_list/presentation/pages/tasks_page/tasks_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int color = context.read<FirebaseRemoteConfig>().getInt('color');
    return MaterialApp(
      theme: ProjectThemeData.getTheme(
        importanceColor: color >= 0
            ? Color(
                color,
              )
            : null,
      ),
      navigatorKey: context.read<NavigationController>().key,
      routes: {
        '/tasks': (context) => const TasksPage(),
        '/edit_tasks': (context) => const EditTaskPage(),
      },
      initialRoute: '/tasks',
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
