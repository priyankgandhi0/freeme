import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeme/globle.dart';
import 'package:get/get_core/src/get_main.dart';

import '../profile/account/account_screen.dart';
import '../profile/beta/beta_screen.dart';
import '../profile/edit_timecard/edit_timecard_screen.dart';
import '../profile/editprofile/editprofile_screen.dart';
import '../profile/myprofile/myprofile_screen.dart';
import '../profile/timecard/timecard_screen.dart';
import '../work_history/history/work_history_screen.dart';
import '../work_history/work_history_detail/history_detail_screen.dart';
import '../work_history/work_history_detail/time_card_edit/timecard_history_edit_screen.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  List<GlobalKey<NavigatorState>> navigatorKeys = [
    _workHistoryNavigatorKey,
    _freeMeNavigatorKey,
    _accountNavigatorKey

  ];
  void onBackPressed() {
     if (navigatorKeys[controller.selectedIndex].currentState?.canPop() ?? false) {
       navigatorKeys[controller.selectedIndex]
          .currentState
          ?.pop(navigatorKeys[controller.selectedIndex].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<HomeController>(
        builder: (ctrl) {
          return Scaffold(
            bottomNavigationBar: bottomNavigationBar(),
            body: SafeArea(
              top: false,
              child: IndexedStack(
                index: ctrl.selectedIndex,
                children: const <Widget>[
                  WorkHistoryNavigator(),
                  FreeMeNavigator(),
                  AccountNavigator(),
                ],
              ),
            ),
          );
        },
      ),
      onWillPop: () async {
        onBackPressed();
        return false;
      },
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 98,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0, -1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomItem(workHistory, Assets.iconsHistory).onClick(() {
            controller.updateSelectedIndex(0);
          }),
          bottomItem(freeMeBeta, Assets.iconsBeta).onClick(() {
            controller.updateSelectedIndex(1);
          }),
          bottomItem(account, Assets.iconsSetting).onClick(() {
            controller.updateSelectedIndex(2);
          }),
        ],
      ),
    );
  }

  Widget bottomItem(String title, String asset) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FmImage.assetImage(
          path: asset,
          height: 26,
          width: 26,
        ),
        title
            .text(
              fontSize: 12,
            )
            .paddingOnly(
              top: 6.sh(),
            )
      ],
    );
  }


}

///work history navigator
class WorkHistoryNavigator extends StatefulWidget {
  const WorkHistoryNavigator({Key? key}) : super(key: key);

  @override
  State<WorkHistoryNavigator> createState() => _WorkHistoryNavigatorState();
}

GlobalKey<NavigatorState> _workHistoryNavigatorKey =
    GlobalKey<NavigatorState>();

class _WorkHistoryNavigatorState extends State<WorkHistoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _workHistoryNavigatorKey,
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
            }
            return Container();
          },
        );
      },
    );
  }
}

///freeme navigator
class FreeMeNavigator extends StatefulWidget {
  const FreeMeNavigator({Key? key}) : super(key: key);

  @override
  State<FreeMeNavigator> createState() => _FreeMeNavigatorState();
}

GlobalKey<NavigatorState> _freeMeNavigatorKey = GlobalKey<NavigatorState>();

class _FreeMeNavigatorState extends State<FreeMeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _freeMeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return BetaScreen();
            }
            return Container();
          },
        );
      },
    );
  }
}

///account navigator
///

class AccountNavigator extends StatefulWidget {
  const AccountNavigator({Key? key}) : super(key: key);

  @override
  State<AccountNavigator> createState() => _AccountNavigatorState();
}

GlobalKey<NavigatorState> _accountNavigatorKey = GlobalKey<NavigatorState>();

class _AccountNavigatorState extends State<AccountNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _accountNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return AccountScreen();
              case Routes.myProfileScreen:
                return MyProfileScreen();
              case Routes.editProfileScreen:
                return EditProfileScreen();
              case Routes.timeCardInfoScreen:
                return TimeCardInfoScreen();
              case Routes.editTimeCardScreen:
                return EditTimeCardScreen();
            }
            return Container();
          },
        );
      },
    );
  }
}
