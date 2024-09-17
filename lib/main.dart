import 'package:flutter/material.dart';
import 'package:machine_test/constants/routes.dart';
import 'package:machine_test/views/home_screen.dart';
import 'package:machine_test/views/login_screen.dart';
import 'package:machine_test/views/otp_screen.dart';
import 'package:machine_test/views/register_screen.dart';
import 'package:machine_test/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        homeRoute: (context) => const HomeScreen(),
        loginRoute: (context) => const LoginScreen(),
        otpRoute: (context) => const OtpScreen(phone: ""),
        registerRoute: (context) => const RegisterScreen(),
        splashRoute: (context) => const SplashScreen()
      },
    );
  }
}
