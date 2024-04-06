import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class SVGAnimationPage extends StatefulWidget {
  const SVGAnimationPage({super.key});

  @override
  _SVGAnimationPageState createState() => _SVGAnimationPageState();
}

class _SVGAnimationPageState extends State<SVGAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value, // Scale the SVG based on animation value
          child: child,
        );
      },
      child: SvgPicture.asset(
        'success'.svg, // Path to your SVG file
        width: 10, // Initial width
        height: 10, // Initial height
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
