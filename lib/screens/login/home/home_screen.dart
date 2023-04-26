import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hello!',
                style: TextStyle(fontSize: 37.0, fontWeight: FontWeight.bold)),
            Text(
                FirebaseAuth.instance.currentUser!.displayName != null
                    ? FirebaseAuth.instance.currentUser!.displayName!
                    : '',
                style: const TextStyle(
                  fontSize: 27.0,
                )),
          ],
        ),
      ),
    );
  }
}
