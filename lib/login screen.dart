import 'package:flutter/material.dart';
import 'package:letmegrab/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future loginnow() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  final _formkey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    decoration:
                        inputDecoration.copyWith(label: const Text("Email")),
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      return RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value!)
                          ? null
                          : "enter a valid email ";
                    },
                  ),
                  const SizedBox(
                    height: 19.0,
                  ),
                  TextFormField(
                    decoration:
                        inputDecoration.copyWith(label: const Text("password")),
                    obscureText: true,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return "atleast 6 characters required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 19.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {
                          loginnow().then((value) {
                            if (value = true) {
                             Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                            }
                          });
                        },
                        child: const Text("Log in")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
