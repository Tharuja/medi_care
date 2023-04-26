import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/screens/login/home/home_screen.dart';
import 'login_screen.dart';

class AuthSwitcher extends StatelessWidget {
  const AuthSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something Went Wrong"));
              } else {
                return const LoginScreen();
              }
            }));
  }
}
