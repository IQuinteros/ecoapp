import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  AlignmentGeometry alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), () => setState(() => alignment = Alignment.bottomCenter));
    return Scaffold(
      backgroundColor: EcoAppColors.BLACK_COLOR,
      body: AnimatedAlign(
        alignment: alignment,
        curve: Curves.easeInCirc,
        duration: Duration(milliseconds: 1500),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0
          ),
          child: Image(
            image: AssetImage('assets/png/logo.png'),
          ),
        ),
      ),
    );
  }
}