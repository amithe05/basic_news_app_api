import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:letmegrab/detailscreen.dart';
import 'package:letmegrab/homescreen.dart';
import 'package:letmegrab/login%20screen.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
            home:const LoginScreen(),

      routes: <String, WidgetBuilder> {
    '/home': (BuildContext context) =>  const HomeScreen(),
    '/login' : (BuildContext context) => const LoginScreen(),
    '/details' : (BuildContext context) => const DetailsScreen(),
  },

    );
  }
}

