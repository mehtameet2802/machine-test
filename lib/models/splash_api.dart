class SplashData {
  String? message;
  String? deviceId;

  SplashData({
    this.message,
    this.deviceId,
  });

  SplashData.fromJson(dynamic json) {
    message = json['message'];
    deviceId = json['deviceId'];
  }
}

class SplashResponse {
  int? status;
  SplashData? data;

  SplashResponse({
    this.status,
    this.data,
  });

  SplashResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? SplashData.fromJson(json['data']) : null;
  }
}

class SplashInput {
  String? deviceType;
  String? deviceId;
  String? deviceName;
  String? deviceOSVersion;
  String? deviceIPAddress;
  double? lat;
  double? long;
  String? buyerGcmid;
  String? buyerPemid;
  App? app;

  SplashInput({
    required this.deviceType,
    required this.deviceId,
    required this.deviceName,
    required this.deviceOSVersion,
    required this.deviceIPAddress,
    required this.lat,
    required this.long,
    required this.buyerGcmid,
    required this.buyerPemid,
    required this.app,
  });

  SplashInput.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    deviceOSVersion = json['deviceOSVersion'];
    deviceIPAddress = json['deviceIPAddress'];
    lat = json['lat'];
    long = json['long'];
    buyerGcmid = json['buyer_gcmid'];
    buyerPemid = json['buyer_pemid'];
    app = json['app'] != null ? App.fromJson(json['app']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['deviceType'] = deviceType.toString();
    data['deviceId'] = deviceId.toString();
    data['deviceName'] = deviceName.toString();
    data['deviceOSVersion'] = deviceOSVersion.toString();
    data['deviceIPAddress'] = deviceIPAddress.toString();
    data['lat'] = lat!.toString();
    data['long'] = long!.toString();
    data['buyer_gcmid'] = buyerGcmid.toString();
    data['buyer_pemid'] = buyerPemid.toString();
    if (app != null) {
      data['app'] = app!.toJson();
    }
    return data;
  }
}

class App {
  String? version;
  String? installTimeStamp;
  String? uninstallTimeStamp;
  String? downloadTimeStamp;

  App({
    required this.version,
    required this.installTimeStamp,
    required this.uninstallTimeStamp,
    required this.downloadTimeStamp,
  });

  App.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    installTimeStamp = json['installTimeStamp'];
    uninstallTimeStamp = json['uninstallTimeStamp'];
    downloadTimeStamp = json['downloadTimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version.toString();
    data['installTimeStamp'] = installTimeStamp.toString();
    data['uninstallTimeStamp'] = uninstallTimeStamp.toString();
    data['downloadTimeStamp'] = downloadTimeStamp.toString();
    return data;
  }
}
