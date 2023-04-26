import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/login/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userEmail = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/wave-haikei.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Please Sign in to continue',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      onChanged: (value) {
                        userEmail = value;
                      },
                      validator: (value) {},
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'User E-mail',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {},
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'User Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        backgroundColor: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: userEmail,
                            password: password,
                          );
                        } on FirebaseAuthException catch (e) {
                          // if (e.code == 'user-not-found') {
                          //   print('No user found for that email.');
                          // } else if (e.code == 'wrong-password') {
                          //   print('Wrong password provided for that user.');
                          // } else {
                          //   print(e.code);
                          // }
                          setState(() {
                            errorMessage = e.code;
                          });
                        } catch (e) {
                          setState(() {
                            errorMessage = e.toString();
                          });
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    onPressed: (() {
                      Get.to(const SignUpPage());
                    }),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
