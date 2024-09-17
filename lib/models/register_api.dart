class RegisterInput {
  String? email;
  String? password;
  int? referralCode;
  String? userId;

  RegisterInput({
    required this.email,
    required this.password,
    this.referralCode,
    required this.userId,
  });

  RegisterInput.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    referralCode = json['referralCode'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['referralCode'] = referralCode;
    data['userId'] = userId;
    return data;
  }
}

class RegisterResponse {
  int? status;
  Data? data;

  RegisterResponse({
    this.status,
    this.data,
  });

  RegisterResponse.fromJson(dynamic json) {
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

  Data({
    this.message,
  });

  Data.fromJson(dynamic json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
