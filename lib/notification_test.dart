// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coin/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class NotificationTest extends StatefulWidget {
//   @override
//   _NotificationTestState createState() => _NotificationTestState();
// }

// class _NotificationTestState extends State<NotificationTest> {
//   String? token;
//   List subscribed = [];
//   List topics = [
//     'Samsung',
//     'Apple',
//     'Huawei',
//     'Nokia',
//     'Sony',
//     'HTC',
//     'Lenovo'
//   ];
//   @override
//   void initState() {
//     super.initState();
//     var initialzationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: initialzationSettingsAndroid);

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 icon: android.smallIcon,
//               ),
//             ));
//       }
//     });
//     getToken();
//     getTopics();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('appbar'),
//           ),
//           body: ListView.builder(
//             itemCount: topics.length,
//             itemBuilder: (context, index) => ListTile(
//               title: Text(topics[index]),
//               trailing: subscribed.contains(topics[index])
//                   ? ElevatedButton(
//                       onPressed: () async {
//                         await FirebaseMessaging.instance
//                             .unsubscribeFromTopic(topics[index]);
//                         await FirebaseFirestore.instance
//                             .collection('topics')
//                             .doc(token)
//                             .update({topics[index]: FieldValue.delete()});
//                         setState(() {
//                           subscribed.remove(topics[index]);
//                         });
//                       },
//                       child: Text('unsubscribe'),
//                     )
//                   : ElevatedButton(
//                       onPressed: () async {
//                         await FirebaseMessaging.instance
//                             .subscribeToTopic(topics[index]);

//                         await FirebaseFirestore.instance
//                             .collection('topics')
//                             .doc(token)
//                             .set({topics[index]: 'subscribe'},
//                                 SetOptions(merge: true));
//                         setState(() {
//                           subscribed.add(topics[index]);
//                         });
//                       },
//                       child: Text('subscribe')),
//             ),
//           )),
//     );
//   }

//   getToken() async {
//     token = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       token = token;
//     });
//     print(token);
//   }

//   getTopics() async {
//     await FirebaseFirestore.instance
//         .collection('topics')
//         .get()
//         .then((value) => value.docs.forEach((element) {
//               if (token == element.id) {
//                 subscribed = element.data().keys.toList();
//               }
//             }));

//     setState(() {
//       subscribed = subscribed;
//     });
//   }
// }
