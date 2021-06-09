import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalInput extends StatelessWidget {
  const NormalInput({
    Key? key,
    required this.header,
    required this.hint,
    required this.icon, 
    this.readOnly = false, 
    this.onTap, 
    this.onChanged,
    this.type = TextInputType.text, 
    this.controller, 
    this.validator, 
    this.isPassword = false,
    this.future
  }) : super(key: key);

  final String header;
  final String hint;
  final IconData icon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Future? future;

  @override
  Widget build(BuildContext context) {

    if(future != null){
      return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return _InputContent(
            controller: controller, 
            type: type, 
            readOnly: readOnly, 
            validator: validator, 
            isPassword: isPassword, 
            hint: hint, 
            header: header, 
            icon: icon, 
            onTap: onTap, 
            onChanged: onChanged
          );
        }
      );
    }
    else{
      return _InputContent(
        controller: controller, 
        type: type, 
        readOnly: readOnly, 
        validator: validator, 
        isPassword: isPassword, 
        hint: hint, 
        header: header, 
        icon: icon, 
        onTap: onTap, 
        onChanged: onChanged
      );
    }
  }
}

class _InputContent extends StatelessWidget {
  const _InputContent({
    Key? key,
    required this.controller,
    required this.type,
    required this.readOnly,
    required this.validator,
    required this.isPassword,
    required this.hint,
    required this.header,
    required this.icon,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType type;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String hint;
  final String header;
  final IconData icon;
  final Function()? onTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.0
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: GoogleFonts.montserrat(),
        readOnly: readOnly,
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: header,
          prefixIcon: Icon(icon)
        ),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
