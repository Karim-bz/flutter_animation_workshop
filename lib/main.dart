import 'package:flutter/material.dart';
import 'package:flutter_animation_workshop/screens/home.dart';
import 'package:flutter_animation_workshop/screens/sandbox.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ninja Trips',
      home: SandBox(),
    );
  }
}