import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilyModifyPassView extends StatefulWidget {

  @override
  _ProfilyModifyPassViewState createState() => _ProfilyModifyPassViewState();
}

class _ProfilyModifyPassViewState extends State<ProfilyModifyPassView> {
  final controllers = {
    'previous': TextEditingController(),
    'pass': TextEditingController(),
    'confirm': TextEditingController(),
  };

  final _formKey = GlobalKey<FormState>();

  String? previousPassValidation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Cambiar contraseña',
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
                    'Modifica tu contraseña anterior',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 20.0,),
            NormalInput(
              header: 'Contraseña anterior', 
              hint: 'Ingresa tu contraseña anterior', 
              icon: Icons.person,
              controller: controllers['previous']!,
              validator: (value) => value!.isEmpty
                ? 'Debe ingresar su contraseña anterior'
                : previousPassValidation,
              isPassword: true,
              onChanged: (value) => previousPassValidation = null,
            ),
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
              },
              isPassword: true,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40.0
              ),
              child: NormalButton(
                text: 'Cambiar contraseña', 
                onPressed: () => changePassword(context)
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePassword(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      final profileBloc = BlocProvider.of<ProfileBloc>(context);

      final loading = AwesomeDialog(
        title: 'Verificando datos',
        desc: 'Solo tomará un momento',
        dialogType: DialogType.NO_HEADER, 
        animType: AnimType.BOTTOMSLIDE,
        context: context,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
      )..show();

      bool validData = await profileBloc.canLogin(profileBloc.currentProfile!.email, controllers['previous']!.text);
      if(!validData){
        setState(() {
          previousPassValidation = 'La contraseña anterior no es correcta';
        });
        loading.dismiss();
      }     

      if(!_formKey.currentState!.validate()) return;

      bool result = await profileBloc.changePassword(controllers['pass']!.text);

      loading.dismiss();
      if(result){
        AwesomeDialog(
          title: 'Contraseña modificada',
          desc: 'Recuerda usar tu nueva contraseña para iniciar sesión en la app',
          dialogType: DialogType.SUCCES, 
          animType: AnimType.BOTTOMSLIDE,
          context: context,
          btnOkText: 'Aceptar',
          btnOkOnPress: (){},
          onDissmissCallback: (__) => Navigator.pop(context),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
        )..show();
      }
      else{
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ha ocurrido un error intentando cambiar la contraseña'),
            backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
          )
        );
      }
      
    }
    
  }
}



