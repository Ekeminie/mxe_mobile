import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  Timer? _timer;

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer
        ?.cancel(); // You can comment-out this line if you want. I am not sure if this call brings any value.
    _timer = null;
  }
}

class DebounceRequest {
  Timer? _timer;
  void run(VoidCallback action, {int? milliSeconds}) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSeconds ?? 1000), action);
  }
}

final debounce = DebounceRequest();
debounceThis(VoidCallback v, {int? milliSeconds}) {
  debounce.run(() {
    v();
  }, milliSeconds: milliSeconds);
}

extension DebounceExtension on Function {
  debounceIt({int? milliseconds}) {
    debounceThis(() => this(), milliSeconds: milliseconds);
  }
}
