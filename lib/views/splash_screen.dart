import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/apis/apis.dart';
import 'package:machine_test/models/splash_api.dart';
import 'package:machine_test/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashResponse? splashResponse;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    navigateToLoginScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.PNG'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void navigateToLoginScreen() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = "";
    String deviceIpAddress = "";
    String deviceOsVersion = "";
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        deviceIpAddress = await getWifiIP();
        deviceOsVersion = androidInfo.version.release;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        deviceIpAddress = await getWifiIP();
        deviceOsVersion = iosInfo.systemVersion;
        deviceName = iosInfo.model;
      }
    } catch (e) {
      deviceName = "";
      deviceIpAddress = "";
      deviceOsVersion = "";
    }

    splashResponse = await Apis().splashScreenApi(
      SplashInput(
        deviceType: "android",
        deviceId: "",
        deviceName: deviceName,
        deviceOSVersion: deviceOsVersion,
        deviceIPAddress: deviceIpAddress,
        lat: 0.0,
        long: 0.0,
        buyerGcmid: "",
        buyerPemid: "",
        app: App(
            version: "1.20.5",
            installTimeStamp: "",
            uninstallTimeStamp: "",
            downloadTimeStamp: ""),
      ),
    );
    if (splashResponse != null) {
      prefs.setString("deviceId", splashResponse!.data!.deviceId!);
      Timer(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      });
    } else {
      Fluttertoast.showToast(msg: "Try after some time");
    }
  }

  Future<String> getWifiIP() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result[0].address;
    } on SocketException catch (_) {
      return 'Could not find a network interface';
    }
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
