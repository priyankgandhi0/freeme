import 'package:flutter/material.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/timecard/time_card_screen.dart';

import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';
import '../../profile/timecard/timecard_screen.dart';
import 'history_detail_controller.dart';

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
                Get.back();
              },
              onTrailingClick: () {
                Navigator.pushNamed(context, Routes.timeCardEditHistoryScreen);
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
                    child: "Summary".text(fontSize: 16),
                  ),
                  Tab(
                    child: "Timecard".text(fontSize: 16),
                  ),
                  Tab(
                    child: "Job Info".text(fontSize: 16),
                  ),
                  Tab(
                    child: "Notes".text(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  TimeCardTabScreen(),
                  TimeCardTabScreen(),
                  TimeCardTabScreen(),
                  TimeCardTabScreen(),

                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: () async {
        Get.back();
        return false;
      },
    );
  }
}
