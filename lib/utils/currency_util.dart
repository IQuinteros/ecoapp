import 'package:intl/intl.dart';

class CurrencyUtil{

  static String formatToCurrencyString(int amount, {String symbol = ''}){

    final numbers = NumberFormat();
    return symbol + numbers.format(amount);

  }

}