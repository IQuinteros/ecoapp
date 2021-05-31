import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/google_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Registrarme',
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Hola! Obtendrás toda la experiencia completa de ayudar al medioambiente y aportar al futuro del planeta y la humanidad',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Solo unos pocos pasos más :)',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            NormalInput(
              header: 'Nombres', 
              hint: 'Ingresa tus nombres', 
              icon: Icons.person,
            ),
            NormalInput(
              header: 'Apellidos', 
              hint: 'Ingresa tus apellidos', 
              icon: Icons.person
            ),
            NormalInput(
              header: 'Email', 
              hint: 'Ingresa tu email', 
              icon: Icons.mail,
              type: TextInputType.emailAddress,
            ),
            NormalInput(
              header: 'Rut', 
              hint: 'Ingresa tu rut', 
              icon: Icons.person,
              type: TextInputType.number,
            ),
            NormalInput(
              header: 'Teléfono - Celular', 
              hint: 'Ingresa tu número de contacto', 
              icon: Icons.phone,
              type: TextInputType.phone,
            ),
            NormalInput(
              header: 'Fecha de nacimiento', 
              hint: 'Ingresa tu fecha de nacimiento', 
              icon: Icons.date_range,
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1900), 
                  lastDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.year,
                );
              },
            ),
            NormalInput(
              header: 'Comuna', 
              hint: 'Ingresa tu comuna', 
              icon: Icons.location_on,
              readOnly: true,
              onTap: (){
                // TODO: Combo Box with districts
               },
            ),
            NormalInput(
              header: 'Dirección', 
              hint: 'Ingresa tu dirección', 
              icon: Icons.location_on
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40.0
              ),
              child: NormalButton(
                text: 'Crear mi cuenta', 
                onPressed: (){}
              ),
            ),
          ],
        ),
      ),
    );
  }

}



