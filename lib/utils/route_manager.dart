import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../ui/start_up/login/login_screen.dart';
import '../ui/start_up/splash/splash_screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String login = "/login";


  static List<GetPage> pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        transition: Transition.noTransition),


  ];
}
