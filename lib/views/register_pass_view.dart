import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPassView extends StatelessWidget {

  final controllers = {
    'pass': TextEditingController(),
    'confirm': TextEditingController(),
  };

  final _formKey = GlobalKey<FormState>();

  final ProfileModel tempProfile;

  RegisterPassView({Key? key, required this.tempProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Casi listos!',
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: mainContent(context)
        ),
      ),
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
                    'Crea una contraseña para tu nueva cuenta',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 20.0,),
            NormalInput(
              header: 'Nueva contraseña', 
              hint: 'Mínimo 6 caracteres', 
              icon: Icons.person,
              controller: controllers['pass']!,
              validator: (value) => value!.isEmpty
                ? 'Debe ingresar su nombre'
                : value.length < 6
                  ? 'Debe tener mínimo 6 caracteres'
                  : null,
              isPassword: true,
            ),
            NormalInput(
              header: 'Repetir contraseña', 
              hint: 'Confirma tu nueva contraseña', 
              icon: Icons.person,
              controller: controllers['confirm']!,
              validator: (String? value) {
                if(value == null || value.isEmpty)
                  return 'Debe confirmar la contraseña';
                  
                if(value != controllers['pass']!.text)
                  return 'Las contraseñas no coinciden';
                
                return null;
              }
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40.0
              ),
              child: NormalButton(
                text: 'Crear mi cuenta', 
                onPressed: () => createAccount(context)
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createAccount(BuildContext context) async {
    if(_formKey.currentState!.validate()){

      final profileBloc = BlocProvider.of<ProfileBloc>(context);
      bool result = await profileBloc.signup(tempProfile, controllers['pass']!.text);

      if(result){
        AwesomeDialog(
          title: 'Cuenta creada exitósamente',
          desc: 'Añade artículos a favoritos y disfruta de la mejor experiencia comprando artículos eco-amigables :)',
          dialogType: DialogType.SUCCES, 
          animType: AnimType.BOTTOMSLIDE,
          context: context,
          btnOkText: 'Aceptar',
          btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          onDissmissCallback: (__) => Navigator.popUntil(context, ModalRoute.withName('/'))
        )..show();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ha ocurrido un error intentando crear la cuenta'),
          backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
        )
      );
      }
    }
    
  }

}



