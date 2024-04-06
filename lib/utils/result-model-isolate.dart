import 'dart:convert';
import 'dart:isolate';

import 'package:mxe_mobile/core/model/res_model.dart';

class ResModelParser {
  ResModelParser(this.encodedJson);
  final String encodedJson;

  Future<ResModel> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort p) async {
    final jsonData = jsonDecode(encodedJson);
    final result = ResModel.fromJson(jsonData);
    Isolate.exit(p, result);
  }
}
