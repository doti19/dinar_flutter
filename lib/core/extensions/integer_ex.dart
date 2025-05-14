import 'package:get/get.dart';

extension PercentSized on int {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on int {
  double get sp => (Get.width / 100 * (this / 3));
}

String formatMoney(int amount, {bool isLease = false}) {
  String suffix = '';
  if (isLease) {
    suffix = '/${'month'.tr}';
  }
  if (amount >= 1000000000) {
    double value = amount / 1000000000;
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3)} ${'billion'.tr}$suffix';
  } else if (amount >= 1000000) {
    double value = amount / 1000000;
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3)} ${'million'.tr}$suffix';
  } else {
    double value = amount / 1000;
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)} ${'thousand'.tr}$suffix';
  }
}

extension FormatMoneyExtension on int {
  String toFormattedMoney({bool isLease = false}) {
    return formatMoney(this, isLease: isLease);
  }

  String get toformatNumberWithCommasK {
    if (this >= 1000000) {
      final tmp = (this ~/ 1000).formatNumberWithCommas;
      return "${tmp}K";
    } else if (this >= 1000) {
      double value = this / 1000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K';
    } else {
      return toString();
    }
  }

  String get formatNumberWithCommas {
    if (this >= 1000) {
      String strNumber = toString();
      String result = '';
      for (int i = strNumber.length - 1; i >= 0; i--) {
        result = strNumber[i] + result;
        if ((strNumber.length - i) % 3 == 0 && i > 0) {
          result = ',$result';
        }
      }
      return result;
    } else {
      return toString();
    }
  }
}

extension ConvertNumberToWords on int {
  String convertNumberToWords() {
    if (this == 0) {
      return 'zero';
    }

    List<String> units = [
      'thousand',
      'million',
      'billion',
      'trillion',
      'quadrillion',
      'quintillion'
    ];
    List<String> words = [];

    int temp = this;
    for (int i = 0; temp > 0; i++) {
      int chunk = temp % 1000;
      if (chunk != 0) {
        if (i > 0) {
          words.insert(0, units[i - 1]);
        }
        words.insert(0, readChunk(chunk));
      }
      temp = temp ~/ 1000;
    }

    return words.join(' ');
  }

  String readChunk(int number) {
    List<String> ones = [
      '',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine'
    ];
    List<String> teens = [
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen'
    ];
    List<String> tens = [
      '',
      '',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety'
    ];
    List<String> chunks = [];

    if (number >= 100) {
      chunks.add(ones[number ~/ 100] + ' hundred');
      number %= 100;
    }
    if (number >= 20) {
      chunks.add(tens[number ~/ 10]);
      number %= 10;
    } else if (number >= 10) {
      chunks.add(teens[number - 10]);
      number = 0;
    }
    if (number > 0) {
      chunks.add(ones[number]);
    }

    return chunks.join(' ');
  }
}
