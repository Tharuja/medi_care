import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../screens/patients/view_patients_screen.dart';

// Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
// Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

class ViewPatientsListNavigator extends StatefulWidget {
  static List<Patient> allPatients = [];

  @override
  _ViewPatientsListNavigatorState createState() =>
      _ViewPatientsListNavigatorState();
}

class _ViewPatientsListNavigatorState extends State<ViewPatientsListNavigator> {
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
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

        ViewPatientsListNavigator.allPatients = [];
        // print(snapshot.data!.docs);
        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          List<MediRecord> mediRecords = [];
          for (var rec in data['mediRecords']) {
            mediRecords.add(MediRecord(
                rec['date'].toDate(), rec['disease'], rec['treatment']));
          }

          ViewPatientsListNavigator.allPatients.add(Patient(
              id: document.id,
              name: data['name'],
              address: data["address"],
              age: data['age'],
              fbs: data['fbs'],
              bpressure: data['bpressure'],
              allergics: data['allergics'],
              other: data['other'],
              mediRecords: mediRecords));
        }
        //snapshot.data!.docs.map((DocumentSnapshot document) {});
        // print(ViewPatientsListNavigator.allPatients[0].name);
        return ViewPatientsListScreen(ViewPatientsListNavigator.allPatients);
      },
    );
  }
}
