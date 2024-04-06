import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mxe_mobile/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;
import 'package:url_launcher/url_launcher_string.dart';

RegExp _numeric = RegExp(r'^-?[0-9]+$');

/// check if the string contains only numbers
bool isNumeric(String str) {
  return _numeric.hasMatch(str);
}

const ext = 0;
final formatCurrency =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
final nairaCurrency =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

String getCurrencySign(String name) {
  return NumberFormat.simpleCurrency(
          name: name.toUpperCase(), locale: Platform.localeName)
      .currencySymbol;
}

convertImage(String? base64Image) {
  return Base64Decoder().convert(base64Image!);
}

//Formats the amount and returns a formatted amount
String formatPrice(String amount) {
  print(amount);
  return nairaCurrency.format(num.parse(amount)).toString();
}

extension StringCasingExtension on String {
  String? validationMessage() => "Please enter a valid $this";
  String? camelCase() => toBeginningOfSentenceCase(this);
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String? trimToken() => contains(":") ? split(":")[1].trim() : this;
  String? trimSpaces() => replaceAll(" ", "");
  String? stripInternationalNumbers() => isNotEmpty
      ? contains("+234")
          ? replaceAll("+234", "0")
          : this
      : "";

  String getInitials() => isNotEmpty
      ? trim().split(RegExp(' +')).map((s) => s[0].toUpperCase()).take(2).join()
      : '';
  String getNumbers() =>
      isNotEmpty ? replaceAll(RegExp('[^0-9]'), '').replaceAll("-", "") : "";
  String getAlphabets() =>
      isNotEmpty ? replaceAll(RegExp('[^A-Za-z]'), '').replaceAll("-", "") : "";
  String getAlphaNumeric() => isNotEmpty
      ? replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll("-", "")
      : "";
  String? trimLength(int startRange) => replaceRange(startRange, length, ".");
  String get inCaps =>
      length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");

  String capitalizeWords() {
    if (isEmpty) return this;

    List<String> words = split(' ');
    words = words.map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      }
      return word;
    }).toList();

    return words.join(' ');
  }

  String get toCPDateFormat =>
      DateFormat('yyyy-MM-dd').format(DateTime.parse(this));

  String get lowerCaseAndTrimSpaces => toLowerCase().replaceAll(" ", "");

  String get toTransactionDateFormat =>
      DateFormat('yyyy-MM-dd').format(DateTime.parse(this));

  String get formatDateTime => DateFormat.yMMMd().format(DateTime.parse(this));
}

extension ImagePath on String {
  String get svg => 'assets/images/$this.svg';
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
}

extension ExtraStringMethods on String? {
  /// Returns `true` if this string is not `null` and not empty.
  bool get isNotNullNorEmpty {
    return this?.isNotEmpty ?? false;
  }

  bool get hasValue => this != null && this!.isNotEmpty;
  void toast({bool success = false}) =>
      showCustomToast(this!, success: success);
}

extension NullCheckerExtensions on num? {
  /// Returns `true` if this num is not `null` and not empty.
  bool get isNotNullNorEmpty {
    return this != null;
  }

  bool get hasValue => this != null && this != 0;
  num get trimAndFormatNum =>
      (num.tryParse(toString().replaceAll(",", "")) ?? 0);
}

extension NumExtensions on int {
  num addPercentage(num v) => this + ((v / 100) * this);
  num getPercentage(num v) => ((v / 100) * this);
  num get trimAndFormatNum =>
      (num.tryParse(toString().replaceAll(",", "")) ?? 0);
}

extension NumExtensionss on num {
  num addPercentage(num v) => (this ?? 0) + ((v / 100) * (this ?? 0));
  num getPercentage(num v) => ((v / 100) * (this ?? 0));
  DateTime mToDate() => DateTime.fromMillisecondsSinceEpoch(toInt());
  String get formatMoney => oCcy.format(this);
}

void openUrl({String? url}) {
  launchUrl(Uri.parse("http://$url"));
}

void openUrlExternal({String? url}) {
  launchUrl(Uri.parse(url ?? "https://eatnourisha.com"),
      mode: LaunchMode.externalApplication);
}

void openMailApp({String? receiver, String? title, String? body}) {
  launchUrl(Uri.parse("mailto:$receiver?subject=$title&body=$body"));
}

void makeCall({String? number}) {
  launchUrl(Uri.parse("tel:$number"));
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension DateUtils on DateTime {
  bool isExpired() => isBefore(DateTime.now());
  String formatDate({String? format = 'MM/dd/yyyy, hh:mm a'}) =>
      DateFormat(format).format(this);

//  Output = 03/03/2022, 08:04 AM
}

extension DynamicConverterExtensions on dynamic {
  /// converts a value to a num
  num? get makeNum {
    return num.tryParse(toString().replaceAll(",", ""));
  }

  String? get str {
    return toString();
  }
}

extension IntConverterExtension on int {
  /// converts a value to a num
  num? get makeNum {
    return num.tryParse(toString().replaceAll(",", ""));
  }

  String? get str {
    return toString();
  }
}

final oCcy = new NumberFormat("#,##0.00", "en_US");
