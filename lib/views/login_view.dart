import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/google_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Iniciar sesión',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: EcoAppColors.MAIN_COLOR,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: mainContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
          onTap: (value){
        },
      )
    );
  }

  Widget mainContent(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: Column(
          children: [
            NormalInput(header: 'Email', hint: 'Ingresa tu email', icon: Icons.mail),
            NormalInput(header: 'Contraseña', hint: 'Ingresa tu contraseña', icon: Icons.vpn_key),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40.0
              ),
              child: NormalButton(
                text: 'Iniciar sesión', 
                onPressed: (){}
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                top: 20.0
              ),
              child: GoogleButton(),
            ),
            SizedBox(height: 10.0,),
            Divider(thickness: 1,),
            Container(
              margin: EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                top: 10.0
              ),
              child: NormalButton(
                text: '¡Soy nuevo! Quiero registrarme', 
                onPressed: (){}
              ),
            ),
          ],
        ),
      ),
    );
  }

}



