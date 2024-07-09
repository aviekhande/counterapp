// ignore_for_file: constant_identifier_names

import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Constants {
  static const String BASE_URL = "https://fcm.googleapis.com/fcm/send";
  static const String KEY_SERVER = "";
  static const String SENDER_ID = "";
}

class NotificationService {
  Future<bool> pushNotification({
    required String title,
    body,
    token,
  }) async {
    Map<String, dynamic> payload = {
      'to': token,
      "notification": {
        "priority": "high",
        "title": title,
        "body": body,
        "sound": "default",
      }
    };
    String dataNotifications = jsonEncode(payload);
    var response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key= ${Constants.KEY_SERVER}"
      },
      body: dataNotifications,
    );
    debugPrint(response.body.toString());
    return true;
  }
}
