import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';

import '../../../utils/route_manager.dart';
import '../add_job/add_job_screen.dart';
import '../quick_entry/quick_entry_screen.dart';
import '../time_card_edit/timecard_history_edit_screen.dart';
import '../work_history/history/work_history_screen.dart';
import '../work_history/work_history_detail/history_detail_screen.dart';

///work history navigator
class WorkHistoryNavigator extends StatefulWidget {
  const WorkHistoryNavigator({Key? key}) : super(key: key);

  @override
  State<WorkHistoryNavigator> createState() => _WorkHistoryNavigatorState();
}

GlobalKey<NavigatorState> workHistoryNavigatorKey = GlobalKey<NavigatorState>();

class _WorkHistoryNavigatorState extends State<WorkHistoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: workHistoryNavigatorKey,
      onPopPage: (route, result) {
        "back".debugPrint;
        return true;
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return WorkHistoryScreen();
              case Routes.workHistoryDetailScreen:
                return WorkHistoryDetailScreen();
              case Routes.timeCardEditHistoryScreen:
                return TimeCardEditHistoryScreen();
              case Routes.addJobScreen:
                return AddJobScreen();
              case Routes.quickEntryScreen:
                return QuickEntryScreen();
            }
            return Container();
          },
        );
      },
    );
  }
}
