import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 5)
class AppHttpResponse {
  @HiveField(1)
  int? statusCode;

  @HiveField(2)
  String? message;

  @HiveField(3)
  Map<String, dynamic>? body;

  AppHttpResponse({
    this.statusCode,
    this.message,
    this.body,
  });

  @override
  String toString() {
    return 'AppHttpResponse{statusCode: $statusCode, message: $message, body: $body}';
  }

  AppHttpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}
