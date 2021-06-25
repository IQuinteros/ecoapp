

import 'package:intl/intl.dart';

class TextValidationUtil{

  static bool validateEmail(String email) =>  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  static bool validateRut(String rut) => RegExp(r"^(\d{1,3}(?:\.\d{1,3}){2}-[\dkK])$").hasMatch(rut) && _validRutDv(rut);

  static String stringToRut(String preRut){
    if(preRut.isEmpty) return '';
    if(preRut.length <= 1) return preRut;
    if(preRut.length > 1){
      if(preRut.length > 9) preRut = preRut.substring(0, 9);
      if(preRut.indexOf('k') >= 0) preRut = preRut.substring(0, preRut.indexOf('k')+1);
      String withoutDv = preRut.substring(0, preRut.length - 1);
      final format = NumberFormat("##,###.###", "tr_TR");
      String formattedWithoutDv = format.format(int.parse(withoutDv));
      return formattedWithoutDv + preRut.replaceRange(preRut.length - 1, preRut.length, '-${preRut[preRut.length-1]}').substring(preRut.length - 1, preRut.length+1);
    }
    return preRut;
  }

  static bool _validRutDv(String rut){
    if(rut.isEmpty) return false;
    if(rut.split('-').length < 2) return false;
    final numberDotsString = rut.split('-')[0];
    final numberRevString = numberDotsString.split('.').reversed.join();
    List<int> results = [];
    for (var i = 0; i < numberRevString.length; i++) {
      int? number = int.tryParse(numberRevString[i]);
      if(number == null) continue;

      results.add(number * (i % 6 + 2));
    }
    final sum = results.reduce((value, element) => value + element);
    final remainder = sum % 11;
    final dv = (remainder) == 10? 'k' : (remainder) == 11? '0' : (remainder).toString();
    return rut.split('-')[1].toLowerCase() == dv;
  }
}