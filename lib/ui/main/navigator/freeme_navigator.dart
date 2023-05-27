import 'package:flutter/material.dart';

import '../profile/beta/beta_screen.dart';

///freeme navigator
class FreeMeNavigator extends StatefulWidget {
  const FreeMeNavigator({Key? key}) : super(key: key);

  @override
  State<FreeMeNavigator> createState() => _FreeMeNavigatorState();
}

GlobalKey<NavigatorState>  freeMeNavigatorKey = GlobalKey<NavigatorState>();

class _FreeMeNavigatorState extends State<FreeMeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key:  freeMeNavigatorKey,
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

