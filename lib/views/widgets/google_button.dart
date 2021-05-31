import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';

class GoogleButton extends StatelessWidget {

  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      text: 'Continuar con Google', 
      leading: Container(
        width: 20,
        height: 20,
        child: Image(
          image: AssetImage('assets/png/google.png'),
          fit: BoxFit.contain,
        ),
      ),
      color: Colors.white,
      textColor: EcoAppColors.MAIN_COLOR,
      onPressed: () {}
    ); 
  }
}