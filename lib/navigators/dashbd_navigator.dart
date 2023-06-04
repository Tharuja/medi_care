import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/screens/dashboard/dashboard_screen.dart';

import '../models/patient.dart';

// Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
// Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

class DashboardNavigator extends StatefulWidget {
  static List<Patient> allPatients = [];

  @override
  _DashboardNavigatorState createState() => _DashboardNavigatorState();
}

class _DashboardNavigatorState extends State<DashboardNavigator> {
  late Stream<QuerySnapshot> _usersStream;
  int totalPatients = 0;
  int todayPatients = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? email = FirebaseAuth.instance.currentUser!.email;
    _usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("patients")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        // print(snapshot.data!.docs);
        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          DateTime today = DateTime.now();
          var formate1 = "${today.year}-${today.month}-${today.day}";

          var addedDateTime =
              DateTime.parse(data['added_date'].toDate().toString());
          var formate2 =
              "${addedDateTime.year}-${addedDateTime.month}-${addedDateTime.day}";

          if (formate1 == formate2) {
            todayPatients++;
          }
        }
        totalPatients = snapshot.data!.docs.length;
        return DashboardScreen(totalPatients, todayPatients);
      },
    );
  }
}
