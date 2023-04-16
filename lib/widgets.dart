import 'package:flutter/material.dart';

const inputDecoration =InputDecoration(
    labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color:Colors.pinkAccent, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.pinkAccent, width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.pinkAccent, width: 2))
  
);