import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
// import 'package:device_apps/device_apps.dart';
import 'package:notifier_listener/notifier_listener.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AndroidNotificationListener _notifications;
  StreamSubscription<NotifierListenerEvent> _subscription;
  List<NotifierListenerEvent> notifications = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(NotifierListenerEvent event) {
    setState(() {
      notifications.add(event);
    });
    // var jsonDatax = json.decode(event.packageExtra);
  }

  void startListening() {
    setState(() {
      notifications = [];
    });
    _notifications = new AndroidNotificationListener();
    try {
      _subscription = _notifications.notificationStream.listen(onData);
    } on NotifierListener catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My notification listener'),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              NotifierListenerEvent notifierListenerEvent = notifications[index];
              return ListTile(
                  // leading: PackageIcon(
                  //   package: NotifierListenerEvent.packageName,
                  // ),
                  title: Text(notifierListenerEvent.packageMessage),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(notifierListenerEvent.packageText, style: TextStyle(fontWeight: FontWeight.w200, color: Colors.red[400])),
                      Text(
                        notifierListenerEvent.packageName,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  )
                  // trailing: Text(NotifierListenerEvent.timeStamp.toString()),
                  );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 2,
                color: Colors.green,
              );
            },
            itemCount: notifications.length),
        floatingActionButton: FloatingActionButton(
          onPressed: startListening,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class PackageIcon extends StatelessWidget {
  final package;
  const PackageIcon({Key key, this.package}) : super(key: key);

  buildPackageWidget() async {
    // Application app = await DeviceApps.getApp(package);
    // print(app.apkFilePath);
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      // child: Image.memory();
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPackageWidget();
  }
}
