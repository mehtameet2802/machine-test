import 'package:flutter/material.dart';
import 'package:machine_test/models/home_exclusive_data.dart';
import 'package:machine_test/models/home_row_data.dart';

const registerBeginText = "Let's Begin!";
const registerCredentialText = "Please enter your credentials to proceed";
const registerEmailText = "Your Email";
const registerPasswordText = "Create Password";
const registerReferralText = "Referral Code (Optional)";

const otpText = "OTP Verification";
const otpMessageText = "We have sent a unique OTP number to your mobile";
const otpSendText = "SEND AGAIN";

const loginText = "Glad to see you!";
const loginMessageText = "Please provide your phone number";
const loginPhoneText = "Phone";
const loginButtonText = "SEND CODE";

const homeExclusiveText = "EXCLUSIVELY FOR YOU";
const homeClickText = "CLICK HERE";
const homeInfoText =
    "You need to provide the required \n documents for you account activation";
const homeKYCText = "KYC Pending";
const homeChatText = "Chat";
const homeSearchText = "Search here";

List<HomeRowData> homeRowDataList = [
  HomeRowData(
    title: "Mobile",
    icon: const Icon(
      Icons.phone_android_outlined,
      color: Colors.white,
    ),
    color: Colors.indigo[300],
  ),
  HomeRowData(
    title: "Laptop",
    icon: const Icon(
      Icons.laptop,
      color: Colors.white,
    ),
    color: Colors.green[600],
  ),
  HomeRowData(
    title: "Camera",
    icon: const Icon(
      Icons.camera_alt_rounded,
      color: Colors.white,
    ),
    color: Colors.pinkAccent[200],
  ),
  HomeRowData(
    title: "LED",
    icon: const Icon(
      Icons.lightbulb_outline,
      color: Colors.white,
    ),
    color: Colors.orange[400],
  )
];

List<HomeExclusiveData> homeExclusiveData = [
  HomeExclusiveData(
    model: "Nokia (16 GB RAM)",
    image: "assets/images/img3.PNG",
    discount: "32%",
  ),
  HomeExclusiveData(
    model: "Redmi (16 GB RAM)",
    image: "assets/images/img4.PNG",
    discount: "14%",
  ),
  HomeExclusiveData(
    model: "Redmi (16 GB RAM)",
    image: "assets/images/img4.PNG",
    discount: "14%",
  ),
  HomeExclusiveData(
    model: "Nokia (16 GB RAM)",
    image: "assets/images/img3.PNG",
    discount: "32%",
  )
];
