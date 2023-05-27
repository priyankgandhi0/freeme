import 'package:flutter/material.dart';
import 'package:freeme/ui/start_up/splash/splash_screen.dart';
import 'package:freeme/utils/route_manager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'constant/app_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreeMe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreeMe',
      getPages: Routes.pages,
      home: SplashScreen(),
    );
  }
}
