import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/main/navigator/work_history_navigator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'account_navigator.dart';
import 'freeme_navigator.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  List<GlobalKey<NavigatorState>> navigatorKeys = [
    workHistoryNavigatorKey,
    freeMeNavigatorKey,
    accountNavigatorKey
  ];

  void onBackPressed() {
    if (navigatorKeys[controller.selectedIndex].currentState?.canPop() ??
        false) {
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
            bottomNavigationBar: bottomNavigationBar(ctrl),
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

  Widget bottomNavigationBar(HomeController ctrl) {
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
          bottomItem(
            title: workHistory,
            asset: Assets.iconsHistory,
            color: ctrl.selectedIndex == 0 ? darkGreenColor2 : null,
          ).onClick(() {
            controller.updateSelectedIndex(0);
          }),
          bottomItem(
            title: freeMeBeta,
            asset: Assets.iconsBeta,
            color: ctrl.selectedIndex == 1 ? darkGreenColor2 : null,
          ).onClick(() {
            controller.updateSelectedIndex(1);
          }),
          bottomItem(
            title: account,
            asset: Assets.iconsSetting,
            color: ctrl.selectedIndex == 2 ? darkGreenColor2 : null,
          ).onClick(() {
            controller.updateSelectedIndex(2);
          }),
        ],
      ),
    );
  }

  Widget bottomItem(
      {required String title, required String asset, Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FmImage.assetImage(
          path: asset ?? "",
          height: 26,
          width: 26,
          color: color ?? greyTextColor,
        ),
        title
            .text(
              fontSize: 12,
              fontColor: color ?? Colors.black,
            )
            .paddingOnly(
              top: 6.sh(),
            )
      ],
    );
  }
}
