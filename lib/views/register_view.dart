import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/district.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/utils/text_util.dart';
import 'package:flutter_ecoapp/views/register_pass_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/district_input.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? emailValidation;

  final controllers = {
    'name': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'rut': TextEditingController(),
    'phone': TextEditingController(),
    'date': TextEditingController(),
    'district': TextEditingController(),
    'location': TextEditingController(),
  };

  final birthday = {
    'birthday': DateTime.now()
  };

  final Map<String, DistrictModel?> selectedDistrict = {
    'district': null
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: mainContent(context)
        ),
      ),
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
              controller: controllers['name']!,
              validator: (value) => value!.isEmpty? 'Debe ingresar su nombre' : null, // TODO: Add validation with length
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
                  return 'Debe ser un email válido';
                
                return emailValidation;
              },
              onChanged: (value) => emailValidation = null,
            ),
            NormalInput(
              header: 'Rut', 
              hint: 'Solo números y dígito verificador', 
              icon: Icons.person,
              type: TextInputType.text,
              controller: controllers['rut']!,
              validator: (value) {
                if(value!.isEmpty) 
                  return 'Debe ingresar su rut';
                if(value.length < 10)
                  return 'Debe tener más de 7 dígitos';
                if(!TextValidationUtil.validateRut(value))
                  return 'El rut no es válido';
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9kK]')),
              ],
              onChanged: (value){
                String newValue = TextValidationUtil.stringToRut(value);
                controllers['rut']!.text = newValue;
                controllers['rut']!.selection = TextSelection.fromPosition(TextPosition(offset: newValue.length));
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
                  return 'Debe ingresar su número de contacto';
                if(value.length < 9)
                  return 'El número de contacto no es válido';
                if(!value.startsWith('9'))
                  return 'El número debe comenzar con 9';
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
                  initialDate: birthday['birthday']!, 
                  firstDate: DateTime(1900), 
                  lastDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.year,
                );
                response.then((value){
                  if(value == null)
                    return;
                  controllers['date']!.text = '${value.day}/${value.month}/${value.year}';
                  birthday['birthday'] = value;
                });
              },
              controller: controllers['date']!,
              validator: (value) => value!.isEmpty? 'Debe ingresar su fecha de nacimiento' : null
            ),
            Divider(thickness: 1,),
            SizedBox(height: 20.0,),
            DistrictInput(
              selectedDistrict: (value) => selectedDistrict['district'] = value,
            ),
            NormalInput(
              header: 'Dirección', 
              hint: 'Ingresa tu dirección', 
              icon: Icons.location_on,
              controller: controllers['location']!,
              validator: (value) => value == null || value.isEmpty? 'Debe ingresar su dirección' : null
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

      final newProfile = ProfileModel(
        id: 0,
        name: controllers['name']!.text,
        lastName: controllers['lastName']!.text,
        email: controllers['email']!.text,
        rut: int.parse(controllers['rut']!.text),
        rutDv: '0',
        contactNumber: int.parse(controllers['phone']!.text),
        birthday: birthday['birthday']!,
        createdDate: DateTime.now(),
        lastUpdateDate: DateTime.now(),
        termsChecked: true,
        location: controllers['location']!.text,
        district: selectedDistrict['district']
      );

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

      if(await profileBloc.exists(newProfile)){
        setState(() {
          emailValidation = 'Ya existe un usuario con ese email';
        });
      }

      loading.dismiss();

      if(!_formKey.currentState!.validate()) return;

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPassView(
        tempProfile: newProfile,
      )));
    }
  }
}



