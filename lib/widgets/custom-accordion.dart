import 'package:flutter/material.dart';

typedef WidgetExpander = Widget Function(BuildContext context, bool v);

class CustomAccordion extends StatelessWidget {
  final WidgetExpander builder;
  // final ValueNotifier<bool> onExpand;
  CustomAccordion({Key? key, required this.builder
      // , required this.onExpand
      })
      : super(key: key);
  final ValueNotifier<bool> show = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: show,
      builder: (context, bool value, child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => {show.value = !show.value},
          child: builder(context, value)),
    );
  }
}
