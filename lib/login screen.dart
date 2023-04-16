import 'package:flutter/material.dart';
import 'package:letmegrab/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _formkey = GlobalKey<FormState>();
  late String email;
  late String password;
   String _errorMessage = '';

  Future loginnow() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

 
 _formkey.currentState!.save();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:email.trim(),
        password:password.trim(),
      );
       Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _errorMessage = 'Wrong password provided for that user.';
        });
      } else {
        setState(() {
          _errorMessage = 'Something went wrong. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Please try again later.';
      });
    

  }

 
   
  }

 
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
                 const SizedBox(height: 12,),
                  if ( _errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style:const TextStyle(color: Colors.red),
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
                        onPressed: loginnow,
                        child: const Text("Log in")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

  