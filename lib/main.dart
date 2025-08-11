import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/app_colors.dart';
// ignore: unused_import
import 'package:my_app/cart_manager.dart';
// ignore: unused_import
import 'package:my_app/splash_screen.dart';
// ignore: unused_import
import 'package:my_app/login_screen.dart';
// ignore: unused_import
import 'package:my_app/signup_screen.dart';
// ignore: unused_import
import 'package:my_app/dashboard_screen.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:my_app/productlist.dart';

void main() {
  // Ensure that the Flutter binding is initialized before running the app
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp()
      .then((_) {
        runApp(const MyApp());
      })
      .catchError((error) {
        // ignore: avoid_print
        print("Firebase initialization error: $error");
      });

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
      //  home: const SplashScreen(),
      home: const DashboardPage(),

      // theme: ,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blue,
          titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
      ),
    );
  }
}
