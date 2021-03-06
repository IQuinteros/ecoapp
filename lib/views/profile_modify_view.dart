import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/utils/text_util.dart';
import 'package:flutter_ecoapp/views/profile_modify_pass_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/district_input.dart';
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

  final Map<String, DistrictModel?> district = {
    'district': null
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
            onPressed: () => _updateProfile(context) // TODO: Save action
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: _ProfileModifyMainContent(
          controllers: controllers,
          profile: profileBloc.currentProfile!,
          updateProfile: (BuildContext context) => _updateProfile(context),
          selectedDistrict: district,
        )
      ),
    );
  }

  void _updateProfile(BuildContext context) async {
    if(!_formKey.currentState!.validate()) return;

    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final profile = profileBloc.currentProfile!;

    profile.name = controllers['name']!.text;
    profile.lastName = controllers['lastName']!.text;
    profile.email = controllers['email']!.text;
    profile.contactNumber = int.parse(controllers['phone']!.text);
    profile.location = controllers['location']!.text;
    DistrictModel? districtModel = district['district'];
    if(districtModel != null)
      profile.districtID = districtModel.id;
    profile.district = districtModel;

    final loading = AwesomeDialog(
      title: 'Actualizando datos',
      desc: 'Tus datos ser??n actualizados en un momento',
      dialogType: DialogType.NO_HEADER, 
      animType: AnimType.BOTTOMSLIDE,
      context: context,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    )..show();
    
    bool updated = await profileBloc.updateProfile(profile);

    loading.dismiss();

    if(updated){
      AwesomeDialog(
        title: 'Datos actualizados',
        desc: 'Tu perfil ha sido actualizado con ??xito',
        dialogType: DialogType.SUCCES, 
        animType: AnimType.BOTTOMSLIDE,
        context: context,
        btnOkText: 'Aceptar',
        btnOkOnPress: () {},
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
      )..show();
    }
    else{
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ha ocurrido un error al guardar los cambios'),
        backgroundColor: EcoAppColors.LEFT_BAR_COLOR,
      ));
    }
  }

}

class _ProfileModifyMainContent extends StatelessWidget {
  _ProfileModifyMainContent({
    Key? key,
    required this.profile,
    required this.controllers,
    required this.updateProfile,
    required this.selectedDistrict
  }) : super(key: key);

  final Map<String, TextEditingController> controllers;
  final ProfileModel profile;
  final Function(BuildContext) updateProfile;
  final Map<String, DistrictModel?> selectedDistrict;

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
                validator: (value) {
                  if(value!.isEmpty) 
                    return 'Debe ingresar su email';
                  if(!TextValidationUtil.validateEmail(value))
                    return 'Debe ser un email v??lido';
                  return null;
                },
              ),
              NormalInput(
                header: 'Celular', 
                hint: '912345678', 
                icon: Icons.phone,
                type: TextInputType.phone,
                controller: controllers['phone']!,
                validator: (value) {
                  if(value!.isEmpty) 
                    return 'Debe ingresar su n??mero de contacto';
                  if(value.length < 9)
                    return 'El n??mero de contacto no es v??lido';
                  if(!value.startsWith('9'))
                    return 'El n??mero debe comenzar con 9';
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 9, 
              ),
              NormalInput(
                header: 'Fecha de nacimiento', 
                hint: 'Ingresa tu fecha de nacimiento', 
                icon: Icons.date_range,
                readOnly: true,
                onTap: () {
                  Future<DateTime?> response = showDatePicker(
                    context: context, 
                    initialDate: profile.birthday, 
                    firstDate: DateTime(1900), 
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.year,
                  );
                  response.then((value){
                    if(value == null)
                      return;
                    controllers['date']!.text = '${value.day}/${value.month}/${value.year}';
                    profile.birthday = value;
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
              DistrictInput(
                selectedDistrict: (value) => selectedDistrict['district'] = value,
                initialDistrict: profile.district,
              ),
              NormalInput(
                header: 'Direcci??n', 
                hint: 'Ingresa tu direcci??n', 
                icon: Icons.location_on,
                controller: controllers['location']!,
                validator: (value) => value == null || value.isEmpty? 'Debe ingresar su direcci??n' : null
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40.0
                ),
                child: NormalButton(
                  text: 'Guardar cambios', 
                  onPressed: () => updateProfile(context)
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
                  text: 'Cambiar contrase??a', 
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ProfilyModifyPassView()))
                ),
              ),
              SizedBox(height: 20.0,),
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

