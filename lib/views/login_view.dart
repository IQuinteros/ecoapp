import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/google_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {

  final controllers = {
    'email': TextEditingController(),
    'pass': TextEditingController(),
  };

  final _formKey = GlobalKey<FormState>();

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
      body: SafeArea(child: Form(key: _formKey, child: mainContent(context))),
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
            NormalInput(
              header: 'Email', 
              hint: 'Ingresa tu email', 
              icon: Icons.mail,
              controller: controllers['email'],
              type: TextInputType.emailAddress,
              validator: (value) => value!.isEmpty
                ? 'Debe ingresar su email'
                : null
            ),
            NormalInput(
              header: 'Contraseña', 
              hint: 'Ingresa tu contraseña', 
              icon: Icons.vpn_key,
              controller: controllers['pass'],
              validator: (value) => value!.isEmpty
                ? 'Debe ingresar su contraseña'
                : null,
              isPassword: true,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40.0
              ),
              child: NormalButton(
                text: 'Iniciar sesión', 
                onPressed: () => _tryLogin(context)
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
                onPressed: () => Navigator.pushNamed(context, 'register')
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tryLogin(BuildContext context) async{
    if(_formKey.currentState!.validate()){
      final profileBloc = BlocProvider.of<ProfileBloc>(context);
      
      final loading = AwesomeDialog(
        title: 'Iniciando sesión',
        desc: 'Danos un momento mientras buscamos tu cuenta',
        dialogType: DialogType.NO_HEADER, 
        animType: AnimType.BOTTOMSLIDE,
        context: context,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
      )..show();

      ProfileModel? profile = await profileBloc.login(controllers['email']!.text, controllers['pass']!.text);

      loading.dismiss();

      if(profile == null){
        AwesomeDialog(
          title: 'Usuario no encontrado',
          desc: 'El email y/o contraseña son incorrectos',
          dialogType: DialogType.ERROR, 
          animType: AnimType.BOTTOMSLIDE,
          context: context,
          btnCancelText: 'Volver',
          btnCancelOnPress: () {},
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
        )..show();
      }
      else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
          content: Text('Bienvenido ${profile.fullName}')
        ));
      }
    }
  }
}



