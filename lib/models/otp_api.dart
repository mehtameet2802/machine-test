class OtpInput {
  String? otp;
  String? deviceId;
  String? userId;

  OtpInput({
    required this.otp,
    required this.deviceId,
    required this.userId,
  });

  OtpInput.fromJson(dynamic json) {
    otp = json['otp'];
    deviceId = json['deviceId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['deviceId'] = deviceId;
    data['userId'] = userId;
    return data;
  }
}

class OtpResponse {
  int? status;
  Data? data;

  OtpResponse({
    this.status,
    this.data,
  });

  OtpResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? registrationStatus;
  String? docId;
  String? gst;
  String? referral;
  String? message;

  Data({
    this.registrationStatus,
    this.docId,
    this.gst,
    this.referral,
    this.message,
  });

  Data.fromJson(dynamic json) {
    registrationStatus = json['registration_status'];
    docId = json['docId'];
    gst = json['gst'];
    referral = json['referral'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_status'] = registrationStatus;
    data['docId'] = docId;
    data['gst'] = gst;
    data['referral'] = referral;
    data['message'] = message;
    return data;
  }
}
