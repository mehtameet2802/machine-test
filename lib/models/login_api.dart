class LoginInput {
  String? mobileNumber;
  String? deviceId;

  LoginInput({
    required this.mobileNumber,
    required this.deviceId,
  });

  LoginInput.fromJson(dynamic json) {
    mobileNumber = json['mobileNumber'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['deviceId'] = deviceId;
    return data;
  }
}

class LoginResponse {
  int? status;
  Data? data;

  LoginResponse({
    this.status,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
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
  String? message;
  String? userId;
  String? deviceId;

  Data({this.message, this.userId, this.deviceId});

  Data.fromJson(dynamic json) {
    message = json['message'];
    userId = json['userId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userId'] = userId;
    data['deviceId'] = deviceId;
    return data;
  }
}
