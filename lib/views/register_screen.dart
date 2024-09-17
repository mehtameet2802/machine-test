import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/apis/apis.dart';
import 'package:machine_test/constants/constants.dart';
import 'package:machine_test/constants/routes.dart';
import 'package:machine_test/models/register_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool _passwordVisible;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _referralCode;
  late RegisterResponse? registerResponse;
  late SharedPreferences prefs;

  @override
  void initState() {
    _passwordVisible = false;
    _email = TextEditingController();
    _password = TextEditingController();
    _referralCode = TextEditingController();
    super.initState();
    _loadSharedPreferences();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _referralCode.dispose();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_email.text.isEmpty || _password.text.isEmpty) {
            Fluttertoast.showToast(msg: "Please enter data");
          } else {
            navigateToHomeScreen();
          }
        },
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(
          (Icons.arrow_forward),
          color: Colors.white,
        ),
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
              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Text(
                registerBeginText,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Text(
                registerCredentialText,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: registerEmailText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: _password,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: registerPasswordText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: _referralCode,
                decoration: const InputDecoration(
                  hintText: registerReferralText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHomeScreen() async {
    int referralCode = -1;
    if (_referralCode.text.isEmpty) {
      referralCode = -1;
    } else {
      referralCode = int.parse(_referralCode.text.toString());
    }

    registerResponse = await Apis().registerScreenApi(
      RegisterInput(
        email: _email.text.toString(),
        password: _password.text.toString(),
        referralCode: (referralCode == -1) ? null : referralCode,
        userId: prefs.getString("userId"),
      ),
    );

    if (registerResponse != null) {
      if (registerResponse!.status == 1) {
        Fluttertoast.showToast(msg: registerResponse!.data!.message!);
        Navigator.pushNamedAndRemoveUntil(
            context, homeRoute, (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(msg: registerResponse!.data!.message!);
      }
    }
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
