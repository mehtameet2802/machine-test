import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/apis/apis.dart';
import 'package:machine_test/constants/constants.dart';
import 'package:machine_test/models/login_api.dart';
import 'package:machine_test/views/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _phone;
  late SharedPreferences prefs;
  late LoginResponse? loginResponse;
  bool status = false;

  @override
  void initState() {
    _phone = TextEditingController();
    _loadSharedPreferences();

    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.PNG'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                loginText,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                loginMessageText,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: _phone,
                decoration: const InputDecoration(
                  hintText: loginPhoneText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 16.0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (_phone.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter phone number");
                  } else if (_phone.text.toString().length == 10 ||
                      _phone.text.toString().length == 12) {
                    navigateToOtpScreen();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter correct phone number");
                  }
                },
                child: const Text(
                  loginButtonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void navigateToOtpScreen() async {
    loginResponse = await Apis().loginScreenApi(
      LoginInput(
        mobileNumber: _phone.text,
        deviceId: prefs.getString("deviceId"),
      ),
    );
    if (loginResponse != null && loginResponse!.status == 1) {
      prefs.setString("phone", _phone.text.toString());
      prefs.setString("deviceId", loginResponse!.data!.deviceId!);
      prefs.setString("userId", loginResponse!.data!.userId!);
      Fluttertoast.showToast(msg: "Otp sent successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phone: _phone.text.toString(),
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Please try again");
      setState(() {
        status = false;
      });
    }
  }
}
