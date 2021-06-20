import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalInput <T> extends StatelessWidget {
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
    this.future,
    this.onDoneSnapshot,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.initialData
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
  final Future<T>? future;
  final Function(T?, bool stillLoading)? onDoneSnapshot;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final T? initialData;

  @override
  Widget build(BuildContext context) {

    if(future != null){
      return FutureBuilder(
        future: future,
        initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            onDoneSnapshot?.call(snapshot.data, false);
          }

          if(snapshot.connectionState == ConnectionState.waiting && initialData != null){
            onDoneSnapshot?.call(snapshot.data, true);
          }

          return _InputContent(
            controller: controller, 
            type: type, 
            readOnly: readOnly, 
            validator: validator, 
            isPassword: isPassword, 
            hint: initialData != null? hint : snapshot.connectionState == ConnectionState.done? hint : 'Cargando', 
            header: snapshot.connectionState == ConnectionState.done? header : 'Cargando',
            icon: icon, 
            onTap: onTap, 
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            enabled: initialData != null? true : snapshot.connectionState == ConnectionState.done,
            maxLength: maxLength,
            maxLines: maxLines
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
        enabled: true,
        header: header, 
        icon: icon, 
        onTap: onTap, 
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        maxLength: maxLength,
        maxLines: maxLines
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
    required this.enabled,
    required this.inputFormatters,
    required this.maxLength,
    required this.maxLines
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
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.0
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        keyboardType: type,
        style: GoogleFonts.montserrat(),
        readOnly: readOnly,
        validator: validator,
        obscureText: isPassword,
        enabled: enabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: header,
          prefixIcon: Icon(icon),
        ),
        onTap: onTap,
        onChanged: onChanged,
        maxLines: maxLines,
      ),
    );
  }
}
