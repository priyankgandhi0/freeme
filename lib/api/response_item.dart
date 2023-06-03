class ResponseItem {
  ResponseItem(
      {this.data,
      this.wholeData,
      required this.message,
      required this.status,
      this.forceLogout,
      this.requestCancelled,
      this.newAuthToken});

  dynamic data;
  dynamic wholeData;
  String message;
  bool status;
  bool? forceLogout = false;
  bool? requestCancelled = false;
  String? newAuthToken;

  factory ResponseItem.fromJson(Map<String, dynamic> json) => ResponseItem(
      data: json["data"],
      message: json["msg"],
      status: json["status"] == 1 || json["status"] == 2,
      forceLogout: json["force_logout"] == 1,
      requestCancelled: json["request_cancelled"],
      newAuthToken: json["new_token"]);

  Map<String, dynamic> toJson() => {
        "data": data,
        "msg": message,
        "status": status,
        "force_logout": forceLogout,
        "request_cancelled": requestCancelled,
        "new_token": newAuthToken
      };
}
