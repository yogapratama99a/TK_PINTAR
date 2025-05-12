import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/presentation/notification_detail_screen.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _Notification();
}

class _Notification extends State<Notification> {
  // PUSH NOTIFICATION
  void firebaseMessaging() async {
    // Initialize
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // FCM Token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "N/A";
      final body = message.notification?.body ?? "N/A";
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(
            body,
            maxLines: 1,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailScreen(title: title, body: body),
                  ),
                );
              },
              child: Text("Next"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        ),
      );
    });
    // aplikasi tidak tertutup di background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "N/A";
      final body = message.notification?.body ?? "N/A";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NotificationDetailScreen(title: title, body: body),
        ),
      );
    });
    // aplikasi berhenti
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final title = message.notification?.title ?? "N/A";
        final body = message.notification?.body ?? "N/A";
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NotificationDetailScreen(title: title, body: body),
          ),
        );
      }
    });
  }

@override
void initState(){
  super.initState();
  // call the function
  firebaseMessaging();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Push Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}
