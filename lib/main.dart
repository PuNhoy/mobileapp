// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/app_colors.dart';
import 'package:my_app/splash_screen.dart';
// ignore: unused_import
import 'package:my_app/login_screen.dart';
// ignore: unused_import
import 'package:my_app/signup_screen.dart';
// ignore: unused_import
import 'package:my_app/dashboard_screen.dart';

void main() {
//  runApp(const MyApp());
   runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: true,
      tools: [...DevicePreview.defaultTools],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Computer App',
       home: const SplashScreen(),
   
      // theme: ,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bgColor,
          titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
      ),
    );
  }
}
