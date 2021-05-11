import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

/// Custom Exception for the plugin,
/// thrown whenever the plugin is used on platforms other than Android
class NotifierListener implements Exception {
  String _cause;

  NotifierListener(this._cause);

  @override
  String toString() {
    return _cause;
  }
}

class NotifierListenerEvent {
  String? packageMessage;
  String? packageName;
  String? packageExtra;
  String? packageText;
  DateTime? timeStamp;

  NotifierListenerEvent({this.packageName, this.packageMessage, this.timeStamp, this.packageExtra, this.packageText});

  factory NotifierListenerEvent.fromMap(Map<dynamic, dynamic> map) {
    DateTime time = DateTime.now();
    String? name = map['packageName'];
    String? message = map['packageMessage'];
    String? text = map['packageText'];
    String? extra = map['packageExtra'];

    return NotifierListenerEvent(packageName: name, packageMessage: message, timeStamp: time, packageText: text, packageExtra: extra);
  }

  @override
  String toString() {
    return "Notification Event \n Package Name: $packageName \n - Timestamp: $timeStamp \n - Package Message: $packageMessage";
  }
}

NotifierListenerEvent _notificationEvent(dynamic data) {
  return new NotifierListenerEvent.fromMap(data);
}

class AndroidNotificationListener {
  static const EventChannel _notificationEventChannel = EventChannel('notifications.eventChannel');

  Stream<NotifierListenerEvent>? _notificationStream;

  Stream<NotifierListenerEvent>? get notificationStream {
    if (Platform.isAndroid) {
      if (_notificationStream == null) {
        _notificationStream = _notificationEventChannel.receiveBroadcastStream().map((event) => _notificationEvent(event));
      }
      return _notificationStream;
    }
    throw NotifierListener('Notification API exclusively available on Android!');
  }
}
