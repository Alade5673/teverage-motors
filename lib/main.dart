import 'package:flutter/material.dart';
import 'package:teverage_motors/onboarding/onboarding.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(
      seconds: 3),
      (){
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => Home(),
          ),
          );
    });
  }

@override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body:  Center(
        child: Image( 
            height: 164.00,
            width: 334.00,
            image: AssetImage("assets/edited_logo.png"), 
    ),
        ),
      );
      }
}