const exp = 0;

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

extension StringConverterExtensions on String {
  /// converts a value to a num
  num? get makeNum {
    return num.tryParse(toString().replaceAll(",", ""));
  }

  String? get str {
    return toString();
  }
}
