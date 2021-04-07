import 'package:intl/intl.dart';

class CurrencyUtil{

  static String formatToCurrencyString(int amount){

    final numbers = NumberFormat();
    return numbers.format(amount);

  }

}