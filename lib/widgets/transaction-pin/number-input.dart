import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class NumberInput extends StatefulWidget {
  final ValueChanged<String>? onTap;
  final Function(String)? onCompleted;
  final bool usePinLength;
  final bool isForPrice;
  final bool biometrics;

  NumberInput(
      {Key? key,
      this.onTap,
      this.onCompleted,
      this.usePinLength = true,
      this.biometrics = true,
      this.isForPrice = false})
      : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  String pin = "";

  bool get pinLengthReached => pin.length == 4;

  void numberClicked(String num) {
    if (!pinLengthReached && widget.usePinLength) {
      pin = pin + num;
      widget.onTap!(pin);
      pin.length == 4 ? {widget.onCompleted!(pin), pin = ""} : null;
    } else if (!widget.usePinLength) {
      pin = pin + num;

      //if isForPrice=true format the entered text to look like price
      widget.isForPrice
          ? widget.onTap!(formatPrice(
              pin,
            ))
          : widget.onTap!(pin);
    }
    setState(() {});
  }

  void deleteNum() {
    print('here');
    setState(() {
      if (pin.isNotEmpty && widget.usePinLength) {
        List<String> c = pin.split("");
        c.removeLast();
        pin = c.join();
        widget.onTap!(pin);
      } else if (!widget.usePinLength && pin.isNotEmpty) {
        pin = pin.split(".")[0];
        List<String> c = pin.split("");
        c.removeLast();
        pin = c.join();
        pin.isEmpty
            ? widget.onTap!(formatPrice(
                "0",
              ))
            : widget.onTap!(formatPrice(
                pin,
              ));
      }
    });
  }

  final TextStyle _style = GoogleFonts.plusJakartaSans(
      fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.moderateBlue);
  Color get hasInputColor => primaryLight;
  double get hasInputSize => 18;
  double get noInputSize => 14;
  double get textPadding => 16;
  double get rowPadding => 8;

  Color getTextColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
// the color to return when button is in pressed, hovered, focused state
      return Colors.red;
    }
// the color to return when button is in it's normal/unfocused state
    return Colors.yellow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // for (int i = 1; i <= 4; i++)
          //     Container(
          //       height: pin.isNotEmpty ? hasInputSize : noInputSize,
          //       width: pin.isNotEmpty ? hasInputSize : noInputSize,
          //       margin: const EdgeInsets.symmetric(horizontal: 20),
          //       decoration: BoxDecoration(
          //           color: pin.isNotEmpty
          //               ? hasInputColor
          //               : const Color(0xFFD9D9D9)),
          //     ),
          //     Container(
          //       height: pin.length >= 2 ? hasInputSize : noInputSize,
          //       width: pin.length >= 2 ? hasInputSize : noInputSize,
          //       margin: const EdgeInsets.symmetric(horizontal: 20),
          //       decoration: BoxDecoration(
          //           color: pin.length >= 2
          //               ? hasInputColor
          //               : const Color(0xFFD9D9D9)),
          //     ),
          //     Container(
          //       height: pin.length >= 3 ? hasInputSize : noInputSize,
          //       width: pin.length >= 3 ? hasInputSize : noInputSize,
          //       margin: const EdgeInsets.symmetric(horizontal: 20),
          //       decoration: BoxDecoration(
          //           color: pin.length >= 3
          //               ? hasInputColor
          //               : const Color(0xFFD9D9D9)),
          //     ),
          //     Container(
          //       height: pin.length >= 4 ? hasInputSize : noInputSize,
          //       width: pin.length >= 4 ? hasInputSize : noInputSize,
          //       margin: const EdgeInsets.symmetric(horizontal: 20),
          //       decoration: BoxDecoration(
          //           color: pin.length >= 4
          //               ? hasInputColor
          //               : const Color(0xFFD9D9D9)),
          //     )
          //   ],
          // ),
          // 30.0.sbH,
          Padding(
            padding: EdgeInsets.symmetric(vertical: rowPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shell(
                  onTap: () => numberClicked("1"),
                  child: Padding(
                      padding: EdgeInsets.all(textPadding),
                      child: Text("1", style: _style)),
                ),
                Shell(
                  onTap: () => numberClicked("2"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text(
                      "2",
                      style: _style,
                    ),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("3"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("3", style: _style),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: rowPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shell(
                  onTap: () => numberClicked("4"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("4", style: _style),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("5"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("5", style: _style),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("6"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("6", style: _style),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: rowPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shell(
                  onTap: () => numberClicked("7"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("7", style: _style),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("8"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("8", style: _style),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("9"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("9", style: _style),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: rowPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.biometrics,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Shell(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset('biometric'.svg)),
                  ),
                ),
                Shell(
                  onTap: () => numberClicked("0"),
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: Text("0", style: _style),
                  ),
                ),
                Shell(
                  onTap: () => deleteNum(),
                  child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset('chevron-left'.svg)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Shell extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  const Shell({super.key, required this.child, required this.onTap});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ValueNotifier<Color> myColor = ValueNotifier(AppColors.subtleAccent);
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myColor,
      builder: (context, color, _) => GestureDetector(
        onTapUp: (_) {
          myColor.value = AppColors.subtleAccent;
        },
        onTapDown: (_) {
          myColor.value = AppColors.moderateBlue;
        },
        onVerticalDragStart: (_) {
          myColor.value = AppColors.subtleAccent;
        },
        onHorizontalDragStart: (_) {
          myColor.value = AppColors.subtleAccent;
        },
        onTap: () async => {
          myColor.value = AppColors.moderateBlue,
          widget.onTap(),
          await Future.delayed(const Duration(milliseconds: 100)),
          myColor.value = AppColors.subtleAccent
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color, //AppColors.subtleAccent,
                shape: BoxShape.circle),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
