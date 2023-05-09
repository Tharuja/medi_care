import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/background_wave_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackgroundWaveContainer(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  'Hello ${FirebaseAuth.instance.currentUser!.displayName != null ? FirebaseAuth.instance.currentUser!.displayName! : ''}',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Signika")),
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                elevation: 5,
                color: Color.fromARGB(255, 1, 1, 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: const [
                    Text(
                      "Total patients:      50",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Today patients:    10",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ]),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                elevation: 5,
                color: Color.fromARGB(255, 1, 1, 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Text(
                      "Total patients:      50",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Today patients:    10",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        primary: Colors.deepPurple[600],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {},
                      child: Text("View My Patients"))),
            ],
          ),
        )
      ],
    );
  }
}
