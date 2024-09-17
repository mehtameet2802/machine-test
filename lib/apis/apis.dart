import 'package:machine_test/models/login_api.dart';
import 'package:machine_test/models/otp_api.dart';
import 'package:machine_test/models/register_api.dart';
import 'package:machine_test/models/splash_api.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://devapiv4.dealsdray.com/api/v2/user";
const header = {'Content-Type': 'application/json'};

class Apis {
  Future<SplashResponse?> splashScreenApi(SplashInput splashInput) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/device/add"),
        body: jsonEncode(splashInput),
      );

      if (response.statusCode == 200) {
        return SplashResponse.fromJson(jsonDecode(response.body));
      } else {
        debugPrint("splash screen api did not work  ========== \n $response");
      }
    } catch (e) {
      debugPrint("splash screen api not working error =========== $e");
    }
    return null;
  }

  Future<LoginResponse?> loginScreenApi(LoginInput loginInput) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/otp"),
        headers: header,
        body: jsonEncode(loginInput),
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        debugPrint("login screen api did not work ====== \n $response");
      }
    } catch (e) {
      debugPrint("login screen api not working error =========== $e");
    }
    return null;
  }

  Future<OtpResponse?> otpScreenApi(OtpInput otpInput) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/otp/verification"),
        headers: header,
        body: jsonEncode(otpInput),
      );
      if (response.statusCode == 200) {
        return OtpResponse.fromJson(jsonDecode(response.body));
      } else {
        debugPrint("login screen api did not work ====== \n $response");
      }
    } catch (e) {
      debugPrint("otp screen api not working error =========== $e");
    }
    return null;
  }

  Future<RegisterResponse?> registerScreenApi(
      RegisterInput registerReponse) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/email/referral"),
        headers: header,
        body: jsonEncode(registerReponse),
      );
      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 409) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        debugPrint("register screen api did not work ====== \n $response");
      }
    } catch (e) {
      debugPrint("register screen api not working error =========== $e");
    }
    return null;
  }
}
