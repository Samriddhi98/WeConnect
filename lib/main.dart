import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/screens/home.dart';

void main() async {
  //enable us to use timestamp in our documnets
  // FirebaseFirestore.instance.settings(timestampsInSnapshotsEnabled: true).then(
  //     (_) {
  //   print('timestamp enabled\n');
  // }, onError: (_) {
  //   print('error enabling timestamp\n');
  // });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.teal),
      home: Home(),
    );
  }
}
