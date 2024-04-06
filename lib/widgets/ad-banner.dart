import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class BannerImages extends StatefulWidget {
  List<String>? banner;
  BannerImages({
    super.key,
    this.banner,
  });

  @override
  State<BannerImages> createState() => _BannerImagesState();
}

class _BannerImagesState extends State<BannerImages> {
  int activePage = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.banner?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, pos) {
                        activePage = pos;
                        bool active = pos == activePage;
                        double margin = active ? 10 : 20;
                        return Center(
                            child: AnimatedContainer(
                          margin: EdgeInsets.all(margin),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                          child: Image.asset(
                            widget.banner?[activePage] ?? "",
                            width: width(context) - 40,
                            fit: BoxFit.cover,
                          ),
                        ));
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageIndicator(widget.banner?.length, activePage),
                ),
              ],
            )),
      ],
    );
  }

  List<Widget> imageIndicator(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength ?? 0, (index) {
      return Container(
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? AppColors.moderateBlue
              : const Color(0xFFD9D9D9),
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
