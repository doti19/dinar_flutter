import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:get/get.dart';

extension StringX on String {
  /// Viết hoa chữ cái đầu
  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return this;
  }

  double removeTrailingZerosAndNumberfy(String n) {
    if (n.contains('.')) {
      return double.parse(n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"),
              "") //remove all trailing 0's and extra decimals at end if any
          );
    } else {
      return double.parse(n);
    }
  }

  /// Parse string sang double (trả về default value thay vì throw lỗi)
  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }

  /// check string is number
  bool isNumeric() {
    if (this == "") {
      return false;
    }
    return double.tryParse(this) != null;
  }

  String noAccentVietnamese() {
    String s = this;
    s = s.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    s = s.replaceAll(RegExp(r'[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]'), 'A');
    s = s.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    s = s.replaceAll(RegExp(r'[ÈÉẸẺẼÊỀẾỆỂỄ]'), 'E');
    s = s.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    s = s.replaceAll(RegExp(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]'), 'O');
    s = s.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    s = s.replaceAll(RegExp(r'[ÌÍỊỈĨ]'), 'I');
    s = s.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    s = s.replaceAll(RegExp(r'[ƯỪỨỰỬỮÙÚỤỦŨ]'), 'U');
    s = s.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    s = s.replaceAll(RegExp(r'[ỲÝỴỶỸ]'), 'Y');
    s = s.replaceAll(RegExp(r'[Đ]'), 'D');
    s = s.replaceAll(RegExp(r'[đ]'), 'd');
    return s;
  }
}

class ValidateString implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'At least - characters'.tr;
  @override
  final String uppercaseLetters = '- Capitalized characters'.tr;
  @override
  final String numericCharacters = '- Numeric characters'.tr;
  @override
  final String specialCharacters = '- Special characters'.tr;
  @override
  final String lowercaseLetters = '- Lowercase characters'.tr;

  @override
  final String normalLetters = '- Regular characters'.tr;
}
