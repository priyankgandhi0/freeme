import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../ui/main/demo/demo_screen.dart';
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
      page: () =>  RegisterScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.demoScreen,
      page: () =>   DemoScreen(),
      transition: Transition.noTransition,
    ),

  ];
}