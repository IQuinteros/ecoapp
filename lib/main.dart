import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/home_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoApp',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomeView()
    );
  }
}