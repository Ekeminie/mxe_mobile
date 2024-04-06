import 'dart:convert';

final String jsonInput = '''
 {
  "provider": "MTN",
  "amount": 0,
  "phoneNumber": "string",
  "transactionPin": "string",
  "userid": "string"
}
  ''';

String generateDartClass(String data, {String className = 'Airtime'}) {
  Map<String, dynamic> jsonData = jsonDecode(data);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('class $className {');

  // Generate properties
  for (final entry in jsonData.entries) {
    buffer.writeln('  String? ${entry.key.toLowerCase()};');
  }

  buffer.writeln();

  // Generate constructor
  buffer.writeln('  $className({');
  for (final entry in jsonData.entries) {
    buffer.writeln('    this.${entry.key.toLowerCase()},');
  }
  buffer.writeln('  });');
  buffer.writeln();

  // Generate fromJson factory method
  buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) {');
  buffer.writeln('    return $className(');
  for (final entry in jsonData.entries) {
    buffer.writeln('      ${entry.key.toLowerCase()}: json[\'${entry.key}\'],');
  }
  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln();

  // Generate toJson method
  buffer.writeln('  Map<String, dynamic> toJson() {');
  buffer.writeln('    return {');
  for (final entry in jsonData.entries) {
    buffer.writeln('      \'${entry.key}\': ${entry.key.toLowerCase()},');
  }
  buffer.writeln('    };');
  buffer.writeln('  }');
  buffer.writeln();

  // Generate toString method
  buffer.writeln('  @override');
  buffer.writeln('  String toString() {');
  buffer.writeln('    return \'$className{\'');
  for (final entry in jsonData.entries) {
    buffer.writeln('        \'${entry.key}\': \$$entry.key.toLowerCase(),');
  }
  buffer.writeln('      \'}\';');
  buffer.writeln('  }');

  buffer.writeln('}');

  return buffer.toString();
}
