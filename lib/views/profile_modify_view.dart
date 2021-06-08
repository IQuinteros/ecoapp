import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/profile_modify_pass_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileModifyView extends StatelessWidget {

  final controllers = {
    'name': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'date': TextEditingController(),
    'district': TextEditingController(),
    'location': TextEditingController(),
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Ajustes de perfil',
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
        actions: [
          IconButton(
            icon: Icon(Icons.done_rounded),
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 35,
            onPressed: (){} // TODO: Save action
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: _ProfileModifyMainContent(
          controllers: controllers,
          profile: profileBloc.currentProfile!
        )
      ),
    );
  }

}

class _ProfileModifyMainContent extends StatelessWidget {
  const _ProfileModifyMainContent({
    Key? key,
    required this.profile,
    required this.controllers,
  }) : super(key: key);

  final Map<String, TextEditingController> controllers;
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: SafeArea(
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
                      'Cambia los datos de tu cuenta',
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
                controller: controllers['name']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su nombre' : null,
              ),
              NormalInput(
                header: 'Apellidos', 
                hint: 'Ingresa tus apellidos', 
                icon: Icons.person,
                controller: controllers['lastName']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar sus apellidos' : null
              ),
              NormalInput(
                header: 'Email', 
                hint: 'Ingresa tu email', 
                icon: Icons.mail,
                type: TextInputType.emailAddress,
                controller: controllers['email']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su email' : null
              ),
              NormalInput(
                header: 'Teléfono - Celular', 
                hint: 'Ingresa tu número de contacto', 
                icon: Icons.phone,
                type: TextInputType.phone,
                controller: controllers['phone']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su número de contacto' : null
              ),
              NormalInput(
                header: 'Fecha de nacimiento', 
                hint: 'Ingresa tu fecha de nacimiento', 
                icon: Icons.date_range,
                readOnly: true,
                onTap: () {
                  Future<DateTime?> response = showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(1900), 
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.year,
                  );
                  response.then((value){
                    if(value == null)
                      return;
                    controllers['date']!.text = '${value.day}/${value.month}/${value.year}';
                  });
                },
                controller: controllers['date']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su fecha de nacimiento' : null
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'Para compras',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              NormalInput(
                header: 'Comuna', 
                hint: 'Ingresa tu comuna', 
                icon: Icons.location_on,
                readOnly: false, // TODO: Change to true
                onTap: (){
                  
                },
                controller: controllers['district']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su comuna' : null
              ),
              NormalInput(
                header: 'Dirección', 
                hint: 'Ingresa tu dirección', 
                icon: Icons.location_on,
                controller: controllers['location']!,
                validator: (value) => value!.isEmpty? 'Debe ingresar su dirección' : null
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.0
                ),
                child: NormalButton(
                  text: 'Guardar cambios', 
                  onPressed: () {} // TODO: Save data
                ),
              ),
              SizedBox(height: 20.0,),
              Divider(thickness: 1,),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.0
                ),
                child: NormalButton(
                  text: 'Cambiar contraseña', 
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ProfilyModifyPassView()))
                ),
              ),
              SizedBox(height: 20.0,),
              Divider(thickness: 1,),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.0
                ),
                child: NormalButton(
                  text: 'Cerrar sesión', 
                  color: EcoAppColors.LEFT_BAR_COLOR,
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (__){
                        return _CloseSessionDialog();
                      }
                      
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );

    controllers['name']!.text = profile.name;
    controllers['lastName']!.text = profile.lastName;
    controllers['email']!.text = profile.email;
    controllers['phone']!.text = profile.contactNumber.toString();
    final birthdayString = '${profile.birthday.day}/${profile.birthday.month}/${profile.birthday.year}';
    controllers['date']!.text = birthdayString;

    controllers['location']!.text = profile.location;

    return content;
  }

}

class _CloseSessionDialog extends StatefulWidget {
  const _CloseSessionDialog({ Key? key }) : super(key: key);

  @override
  __CloseSessionDialogState createState() => __CloseSessionDialogState();
}

class __CloseSessionDialogState extends State<_CloseSessionDialog> {
  bool working = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cerrar sesión'),
      content: !working? Text('¿Quiere cerrar sesión?')
        : Center(child: CircularProgressIndicator()),
      actions: !working? [
        TextButton(
          onPressed: () => logout(context), 
          child: Text('Cerrar sesión'),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(EcoAppColors.MAIN_COLOR),
            foregroundColor: MaterialStateProperty.all(Colors.white)
          ),
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar')
        ),
      ] : [],
    );
  }

  void logout(BuildContext context){
    setState(() => working = true);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final logout = profileBloc.logout();
    logout.then((value) => Navigator.popUntil(context, ModalRoute.withName('/')));
  }
}


