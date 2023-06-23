import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freeme/ui/start_up/splash/splash_screen.dart';
import 'package:freeme/utils/app_constant.dart';
import 'package:freeme/utils/app_utils.dart';
import 'package:freeme/utils/route_manager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'constant/app_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  box = GetStorage();
  dio = Dio();
  AppUtils.putAppDeviceInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FreeMe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages,
      home: const SplashScreen(),
    );
  }
}

