import 'package:intl/intl.dart';

class MoneyUtils {
  static double parseTextToDouble(String moneyText) {
    return double.parse(moneyText
        .replaceAll("R\$", "")
        .replaceAll(".", "")
        .replaceAll(",", ".")
        .trim());
  }

  static String parseDoubleToMoneyText(double value) {
    var result = NumberFormat.currency(locale: 'pt_BR').format(value);
    return result.replaceAll('BRL', '');
  }
}