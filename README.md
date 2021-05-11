# Notification Listener

This plugin ( only availaible on Android due to iOS restrictions ) will allow you to listen to any incoming notifications on an Android device running on Android APi level 21 or more . In another word you can read notifications coming from all the installed applications with deep details

## Features
Here are the details you will get from a notification
- The time Stamp
- The package name
- The package message
- The package text
- The package extra

**Note:** The `PackageExtra` contains more details about each individual notification. It is originally a bundle file. I converted it into a Json and give it to you as a Json String so if you need to use the `PackageExtra` you will have to json decode it as follow

## Android Setup
#### Register a service in the Android Manifest
The plugin uses an Android system service to track notifications. To allow this service to run on your application, the following code should be put inside the Android manifest, between the <application></application> tags.

```xml
<service android:name="com.notifierlistener.notifier_listener.NotificationListener"
    android:label="notifications"
    android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">
    <intent-filter>
        <action android:name="android.service.notification.NotificationListenerService" />
    </intent-filter>
</service>
```

#### Listen to notification events

```
AndroidNotificationListener _notifications;
StreamSubscription<AndroidNotificationListener> _subscription;
subscription = _notifications.notificationStream.listen(onData);
```

Where `the onData()` method handles the incoming `AndroidNotificationListener`.
An example could be:

```
void onData(AndroidNotificationListener event) => print(event.toString());
```
