import 'package:flutter/material.dart';
import 'package:weconnect/widgets/header.dart';
import 'package:weconnect/widgets/progress.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    getUsers();
    // TODO: implement initState
    super.initState();
  }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef
        .orderBy('postCOunt', descending: true)
        // .where('postCount', isGreaterThan: 1)
        //.where('isAdmin', isEqualTo: true)
        .get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
      print(doc.id);
      print(doc.exists);
    });
  }

  getUserById() async {
    final String id = "M5fUHefPWv2LSnr45AFE";
    final DocumentSnapshot doc = await usersRef.doc(id).get();
    print(doc.data());
    print(doc.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: linearProgress(),
    );
  }
}
