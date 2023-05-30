import 'package:flutter/material.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/summery/summery_screen.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/timecard/time_card_screen.dart';

import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';
import '../../profile/timecard/timecard_screen.dart';
import 'history_detail_controller.dart';
import 'job_info/job_info_screen.dart';
import 'notes/notes_screen.dart';

class WorkHistoryDetailScreen extends StatelessWidget {
  WorkHistoryDetailScreen({Key? key}) : super(key: key);

  final controller = Get.put(HistoryDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        body: Column(
          children: [
            fMAppBar2(
              title: "Commercial with Adam",
              description: "Week Ending 7/23/2022",
              context: context,
              onBackClick: () {
                FocusScope.of(context).unfocus();
              },
              onTrailingClick: () {
                if (controller.tabIndex == 1) {
                  Navigator.pushNamed(
                    context,
                    Routes.timeCardEditHistoryScreen,
                  );
                } else if (controller.tabIndex == 2) {
                  Navigator.pushNamed(
                    context,
                    Routes.addJobScreen,
                    arguments: {
                      "ForEdit":true
                    }
                  );
                }
              },
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: darkGreenColor,
                controller: controller.tabController,
                tabs: [
                  Tab(
                    child: summery.text(fontSize: 16),
                  ),
                  Tab(
                    child: timecard.text(fontSize: 16),
                  ),
                  Tab(
                    child: jobInfo.text(fontSize: 16),
                  ),
                  Tab(
                    child: notes.text(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  SummeryScreen(),
                  TimeCardTabScreen(),
                  JobInfoScreen(),
                  NotesScreen(),
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
