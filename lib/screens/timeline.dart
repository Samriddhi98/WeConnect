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
  List<dynamic> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createUser();
    //updateUser();
    // deleteUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true), body: Container());
  }
}

// // getUserById() async {
// //   final String id = "M5fUHefPWv2LSnr45AFE";
// //   final DocumentSnapshot doc = await usersRef.doc(id).get();
// //   print(doc.data());
// //   print(doc.id);
// // }

// createUser() {
//   usersRef
//       .doc("abcdefg")
//       .set({"username": "Jeff", "postCount": 0, "isAdmin": false});
// }

// updateUser() async {
//   final doc = await usersRef.doc("M5fUHefPWv2LSnr45AFE").get();
//   if (doc.exists) {
//     doc.reference
//         .update({"username": "Jill", "postCount": 0, "isAdmin": false});
//   }
//   // usersRef
//   //     .doc("abcdefg")
//   //     .update({"username": "John", "postCount": 0, "isAdmin": false});
// }

// deleteUser() {
//   usersRef.doc("abcdefg").delete();
// }
