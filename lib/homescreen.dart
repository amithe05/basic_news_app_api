import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getHttp();
  

    super.initState();
  }
    void getHttp() async {
      final dio = Dio();

      final response =
          await dio.get('https://inshorts.deta.dev/news?category=all');

        print(response.data['data'][0]['title']);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
