import 'package:flutter/material.dart';

import '../../../utils/route_manager.dart';
import '../profile/account/account_screen.dart';
import '../profile/edit_timecard/edit_timecard_screen.dart';
import '../profile/editprofile/editprofile_screen.dart';
import '../profile/myprofile/myprofile_screen.dart';
import '../profile/timecard/timecard_screen.dart';


class AccountNavigator extends StatefulWidget {
  const AccountNavigator({Key? key}) : super(key: key);

  @override
  State<AccountNavigator> createState() => _AccountNavigatorState();
}

GlobalKey<NavigatorState> accountNavigatorKey = GlobalKey<NavigatorState>();

class _AccountNavigatorState extends State<AccountNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key:  accountNavigatorKey,
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
