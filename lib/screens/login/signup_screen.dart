import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/screens/login/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String userEmail = '';
  String password = '';
  String name = '';
  String errorMessage = '';
  String secondPassword = '';
  bool loadingStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 52.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text('Create your Account',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (value) {
                      secondPassword = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 3, 6, 0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(0, 50),
                      backgroundColor: Colors.teal,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        errorMessage = '';
                      });
                      try {
                        if (name == '' ||
                            userEmail == '' ||
                            password == '' ||
                            secondPassword == '') {
                          setState(() {
                            errorMessage = 'Fields cannot be empty';
                          });
                        } else if (password != secondPassword) {
                          setState(() {
                            errorMessage = 'Password is not matched';
                          });
                        } else {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: userEmail,
                            password: password,
                          );
                          setState(() {
                            loadingStatus = true;
                          });
                          final user = credential.user;

                          await user?.updateDisplayName(name);
                          user?.reload();
                          setState(() {
                            loadingStatus = false;
                          });
                          Get.back();
                        }
                      } on FirebaseAuthException catch (e) {
                        // if (e.code == 'weak-password') {
                        //   print('The password provided is too weak.');
                        // } else if (e.code == 'email-already-in-use') {
                        //   print('The account already exists for that email.');
                        // } else if (e.code == 'invalid-email') {
                        //   print('The account already exists for that email.');
                        // } else {
                        //   print(e.code);
                        // }

                        setState(() {
                          if (e.code == "unknown") {
                            errorMessage = "Pleas enter valid credentials";
                          } else {
                            errorMessage = e.code;
                          }
                        });
                      } catch (e) {
                        setState(() {
                          errorMessage = e.toString();
                        });
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (() {
                            Get.to(const LoginScreen());
                          }),
                          child: const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
