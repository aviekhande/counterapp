import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission not granted');
    }
  }

  final firebaseFirestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;

  Future<void> uploadFcmToken() async {
    log("message");
    try {
      await FirebaseMessaging.instance.getToken().then((token) async {
        print("getToken :$token");
        await firebaseFirestore
            .collection('users1')
            .doc(_currentUser!.uid)
            .set({
          "notificationToken": token,
          "email": _currentUser.email,
        });
      });
      await FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
        print("onTokenRefresh :$token");
        await firebaseFirestore
            .collection('users1')
            .doc(_currentUser!.uid)
            .set({
          "notificationToken": token,
          "email": _currentUser.email,
        });
      });
    } catch (e) {
      rethrow;
    }
  }
}
