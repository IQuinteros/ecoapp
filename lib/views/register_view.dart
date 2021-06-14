import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/utils/email_util.dart';
import 'package:flutter_ecoapp/views/register_pass_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
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
              hint: 'Ingresa tu rut', 
              icon: Icons.person,
              type: TextInputType.number,
              controller: controllers['rut']!,
              validator: (value) {
                if(value!.isEmpty) 
                  return 'Debe ingresar su rut';
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10
            ),
            NormalInput(
              header: 'Teléfono - Celular', 
              hint: 'Ingresa tu número de contacto', 
              icon: Icons.phone,
              type: TextInputType.phone,
              controller: controllers['phone']!,
              validator: (value) => value!.isEmpty? 'Debe ingresar su número de contacto' : null,
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
            /* NormalInput(
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
            ), */
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
        termsChecked: true
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



