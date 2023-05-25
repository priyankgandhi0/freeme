import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../ui/main/demo/demo_screen.dart';
import '../ui/main/profile/account/account_screen.dart';
import '../ui/main/profile/beta/beta_screen.dart';
import '../ui/main/profile/edit_timecard/edit_timecard_screen.dart';
import '../ui/main/profile/editprofile/editprofile_screen.dart';
import '../ui/main/profile/myprofile/myprofile_screen.dart';
import '../ui/main/profile/timecard/timecard_screen.dart';
import '../ui/main/work_history/history/work_history_screen.dart';
import '../ui/main/work_history/work_history_detail/history_detail_screen.dart';
import '../ui/start_up/forgot_password/forgot_password_screen.dart';
import '../ui/start_up/login/login_screen.dart';
import '../ui/start_up/register/register_screen.dart';
import '../ui/start_up/splash/splash_screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgetPassoword";
  static const String demoScreen = "/demoScreen";
  static const String accountScreen = "/accountScreen";
  static const String myProfileScreen = "/myProfileScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String timeCardScreen = "/timeCardScreen";
  static const String editTimeCardScreen = "/editTimeCardScreen";
  static const String betaScreen = "/betaScreen";
  static const String workHistory = "/workHistory";
  static const String workHistoryDetail = "/workHistoryDetail";

  static List<GetPage> pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.demoScreen,
      page: () => DemoScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.accountScreen,
      page: () => const AccountScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.myProfileScreen,
      page: () => MyProfileScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.editProfileScreen,
      page: () => EditProfileScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.timeCardScreen,
      page: () => const TimeCardInfoScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.editTimeCardScreen,
      page: () => const EditTimeCardScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.betaScreen,
      page: () => const BetaScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.workHistory,
      page: () => WorkHistoryScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.workHistoryDetail,
      page: () => WorkHistoryDetailScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
