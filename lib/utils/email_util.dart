

class TextValidationUtil{

  static bool validateEmail(String email) =>  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  static bool validateRut(String rut) => RegExp(r"^(\d{1,3}(?:\.\d{1,3}){2}-[\dkK])$").hasMatch(rut);
}