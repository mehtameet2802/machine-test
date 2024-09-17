import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/apis/apis.dart';
import 'package:machine_test/constants/constants.dart';
import 'package:machine_test/constants/routes.dart';
import 'package:machine_test/models/login_api.dart';
import 'package:machine_test/models/otp_api.dart';
import 'package:machine_test/views/register_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({
    super.key,
    required this.phone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late SharedPreferences prefs;
  late OtpResponse? otpResponse;
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 120000;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    controller = CountdownTimerController(endTime: endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Visibility(
            visible: Navigator.canPop(context),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img.PNG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                otpText,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Text(
                "$otpMessageText ${widget.phone}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Pinput(
                  onCompleted: (pin) {
                    navigateSreen(pin);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  child: CountdownTimer(
                    controller: controller,
                    endTime: endTime,
                    onEnd: () {
                      Fluttertoast.showToast(msg: "OTP expired");
                    },
                    widgetBuilder: (_, time) {
                      if (time == null) {
                        return const Text(
                          "00:00",
                          style: TextStyle(fontSize: 16),
                        );
                      }
                      if (time.min != null && time.sec! < 10) {
                        return Text(
                          "0${time.min}:0${time.sec}",
                          style: const TextStyle(fontSize: 16),
                        );
                      }
                      if (time.min == null && time.sec! >= 10) {
                        return Text(
                          "00:${time.sec}",
                          style: const TextStyle(fontSize: 16),
                        );
                      }
                      if (time.min == null && time.sec! < 10) {
                        return Text(
                          "00:0${time.sec}",
                          style: const TextStyle(fontSize: 16),
                        );
                      }
                      return Text(
                        "0${time.min}:${time.sec}",
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextButton(
                    onPressed: () {
                      sendOtpAgain();
                    },
                    child: const Text(
                      otpSendText,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateSreen(String otp) async {
    String? deviceId = prefs.getString("deviceId");
    String? userId = prefs.getString("userId");
    if (deviceId == null || userId == null) {
      Fluttertoast.showToast(msg: "Please enter your number again");
    } else {
      otpResponse = await Apis()
          .otpScreenApi(OtpInput(otp: otp, deviceId: deviceId, userId: userId));
      if (otpResponse != null) {
        if (otpResponse!.status == 0) {
          Fluttertoast.showToast(msg: "Please Resend OTP");
        } else if (otpResponse!.data!.registrationStatus == "Incomplete") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            ),
          );
        } else if (otpResponse!.status == 3) {
          Fluttertoast.showToast(msg: "Invalid OTP");
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, homeRoute, (Route<dynamic> route) => false);
        }
      } else {
        Fluttertoast.showToast(msg: "Please try again");
        Navigator.pop(context);
      }
    }
  }

  void sendOtpAgain() async {
    LoginResponse? loginResponse = await Apis().loginScreenApi(
      LoginInput(
        mobileNumber: prefs.getString("phone"),
        deviceId: prefs.getString("deviceId"),
      ),
    );
    if (loginResponse != null && loginResponse.status == 1) {
      prefs.setString("deviceId", loginResponse.data!.deviceId!);
      prefs.setString("userId", loginResponse.data!.userId!);
      Fluttertoast.showToast(msg: "Otp sent successfully");
    } else {
      Fluttertoast.showToast(msg: "Please try again");
    }
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
