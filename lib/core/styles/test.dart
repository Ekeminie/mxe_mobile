import 'package:flutter/material.dart';

abstract class AppC {
  /// brandLinear figma properties
  /// start,stop hex: (#0828b1,#051348)
  /// start,stop opacity: (1,1)
  static const List<Color> brandLinear = <Color>[
    Color(0xff0828b1),
    Color(0xff051348),
  ];

  /// linear figma properties
  /// start,stop hex: (#0e2365,#44a6fe)
  /// start,stop opacity: (1,1)
  static const List<Color> linear = <Color>[
    Color(0xff0e2365),
    Color(0xff44a6fe),
  ];

  /// grey100 figma properties
  /// hex: #131214
  /// opacity: 1
  static const Color grey100 = Color(0xff131214);

  /// grey90 figma properties
  /// hex: #1f2224
  /// opacity: 1
  static const Color grey90 = Color(0xff1f2224);

  /// grey80 figma properties
  /// hex: #2f3133
  /// opacity: 1
  static const Color grey80 = Color(0xff2f3133);

  /// grey70 figma properties
  /// hex: #53575a
  /// opacity: 1
  static const Color grey70 = Color(0xff53575a);

  /// grey60 figma properties
  /// hex: #6e7375
  /// opacity: 1
  static const Color grey60 = Color(0xff6e7375);

  /// grey50 figma properties
  /// hex: #898d8f
  /// opacity: 1
  static const Color grey50 = Color(0xff898d8f);

  /// grey40 figma properties
  /// hex: #c1c4c6
  /// opacity: 1
  static const Color grey40 = Color(0xffc1c4c6);

  /// grey30 figma properties
  /// hex: #daddde
  /// opacity: 1
  static const Color grey30 = Color(0xffdaddde);

  /// grey20 figma properties
  /// hex: #e8ebeb
  /// opacity: 1
  static const Color grey20 = Color(0xffe8ebeb);

  /// grey10 figma properties
  /// hex: #f4f6f7
  /// opacity: 1
  static const Color grey10 = Color(0xfff4f6f7);

  /// greyWhite figma properties
  /// hex: #ffffff
  /// opacity: 1
  static const Color greyWhite = Color(0xffffffff);

  /// primary100 figma properties
  /// hex: #130d33
  /// opacity: 1
  static const Color primary100 = Color(0xff130d33);

  /// primary90 figma properties
  /// hex: #291f61
  /// opacity: 1
  static const Color primary90 = Color(0xff291f61);

  /// primary80 figma properties
  /// hex: #34228f
  /// opacity: 1
  static const Color primary80 = Color(0xff34228f);

  /// primary70 figma properties
  /// hex: #5336e2
  /// opacity: 1
  static const Color primary70 = Color(0xff5336e2);

  /// primary60 figma properties
  /// hex: #7257ff
  /// opacity: 1
  static const Color primary60 = Color(0xff7257ff);

  /// primary50 figma properties
  /// hex: #907aff
  /// opacity: 1
  static const Color primary50 = Color(0xff907aff);

  /// primary40 figma properties
  /// hex: #b4a6ff
  /// opacity: 1
  static const Color primary40 = Color(0xffb4a6ff);

  /// primary30 figma properties
  /// hex: #dbd4ff
  /// opacity: 1
  static const Color primary30 = Color(0xffdbd4ff);

  /// primary20 figma properties
  /// hex: #f0edff
  /// opacity: 1
  static const Color primary20 = Color(0xfff0edff);

  /// primary10 figma properties
  /// hex: #f6f5ff
  /// opacity: 1
  static const Color primary10 = Color(0xfff6f5ff);

  /// green100 figma properties
  /// hex: #021f10
  /// opacity: 1
  static const Color green100 = Color(0xff021f10);

  /// green90 figma properties
  /// hex: #05381d
  /// opacity: 1
  static const Color green90 = Color(0xff05381d);

  /// green80 figma properties
  /// hex: #0d4f2b
  /// opacity: 1
  static const Color green80 = Color(0xff0d4f2b);

  /// green70 figma properties
  /// hex: #006341
  /// opacity: 1
  static const Color green70 = Color(0xff006341);

  /// green60 figma properties
  /// hex: #008557
  /// opacity: 1
  static const Color green60 = Color(0xff008557);

  /// green50 figma properties
  /// hex: #23a15d
  /// opacity: 1
  static const Color green50 = Color(0xff23a15d);

  /// green40 figma properties
  /// hex: #51c285
  /// opacity: 1
  static const Color green40 = Color(0xff51c285);

  /// green30 figma properties
  /// hex: #9bebbf
  /// opacity: 1
  static const Color green30 = Color(0xff9bebbf);

  /// green20 figma properties
  /// hex: #d7f5e5
  /// opacity: 1
  static const Color green20 = Color(0xffd7f5e5);

  /// green10 figma properties
  /// hex: #e8faf0
  /// opacity: 1
  static const Color green10 = Color(0xffe8faf0);

  /// yellow100 figma properties
  /// hex: #331c03
  /// opacity: 1
  static const Color yellow100 = Color(0xff331c03);

  /// yellow90 figma properties
  /// hex: #4d2b05
  /// opacity: 1
  static const Color yellow90 = Color(0xff4d2b05);

  /// yellow80 figma properties
  /// hex: #663c0c
  /// opacity: 1
  static const Color yellow80 = Color(0xff663c0c);

  /// yellow70 figma properties
  /// hex: #824b0d
  /// opacity: 1
  static const Color yellow70 = Color(0xff824b0d);

  /// yellow60 figma properties
  /// hex: #b26205
  /// opacity: 1
  static const Color yellow60 = Color(0xffb26205);

  /// yellow50 figma properties
  /// hex: #d67507
  /// opacity: 1
  static const Color yellow50 = Color(0xffd67507);

  /// yellow40 figma properties
  /// hex: #ed9b16
  /// opacity: 1
  static const Color yellow40 = Color(0xffed9b16);

  /// yellow30 figma properties
  /// hex: #ffd84d
  /// opacity: 1
  static const Color yellow30 = Color(0xffffd84d);

  /// yellow20 figma properties
  /// hex: #ffefb3
  /// opacity: 1
  static const Color yellow20 = Color(0xffffefb3);

  /// yellow10 figma properties
  /// hex: #fff9e6
  /// opacity: 1
  static const Color yellow10 = Color(0xfffff9e6);

  /// red100 figma properties
  /// hex: #290800
  /// opacity: 1
  static const Color red100 = Color(0xff290800);

  /// red90 figma properties
  /// hex: #611000
  /// opacity: 1
  static const Color red90 = Color(0xff611000);

  /// red80 figma properties
  /// hex: #8a1700
  /// opacity: 1
  static const Color red80 = Color(0xff8a1700);

  /// red70 figma properties
  /// hex: #ad1d00
  /// opacity: 1
  static const Color red70 = Color(0xffad1d00);

  /// red60 figma properties
  /// hex: #db340b
  /// opacity: 1
  static const Color red60 = Color(0xffdb340b);

  /// red50 figma properties
  /// hex: #ff5226
  /// opacity: 1
  static const Color red50 = Color(0xffff5226);

  /// red40 figma properties
  /// hex: #ff9175
  /// opacity: 1
  static const Color red40 = Color(0xffff9175);

  /// red30 figma properties
  /// hex: #ffcec2
  /// opacity: 1
  static const Color red30 = Color(0xffffcec2);

  /// red20 figma properties
  /// hex: #ffe9e3
  /// opacity: 1
  static const Color red20 = Color(0xffffe9e3);

  /// red10 figma properties
  /// hex: #fff3f0
  /// opacity: 1
  static const Color red10 = Color(0xfffff3f0);

  /// blue100 figma properties
  /// hex: #021026
  /// opacity: 1
  static const Color blue100 = Color(0xff021026);

  /// blue90 figma properties
  /// hex: #042961
  /// opacity: 1
  static const Color blue90 = Color(0xff042961);

  /// blue80 figma properties
  /// hex: #003c94
  /// opacity: 1
  static const Color blue80 = Color(0xff003c94);

  /// blue70 figma properties
  /// hex: #0050c7
  /// opacity: 1
  static const Color blue70 = Color(0xff0050c7);

  /// blue60 figma properties
  /// hex: #0a69fa
  /// opacity: 1
  static const Color blue60 = Color(0xff0a69fa);

  /// blue50 figma properties
  /// hex: #308aff
  /// opacity: 1
  static const Color blue50 = Color(0xff308aff);

  /// blue40 figma properties
  /// hex: #75b1ff
  /// opacity: 1
  static const Color blue40 = Color(0xff75b1ff);

  /// blue30 figma properties
  /// hex: #c2dcff
  /// opacity: 1
  static const Color blue30 = Color(0xffc2dcff);

  /// blue20 figma properties
  /// hex: #e5f0ff
  /// opacity: 1
  static const Color blue20 = Color(0xffe5f0ff);

  /// blue10 figma properties
  /// hex: #f2f7ff
  /// opacity: 1
  static const Color blue10 = Color(0xfff2f7ff);

  /// socialApplePrimary figma properties
  /// hex: #131214
  /// opacity: 1
  static const Color socialApplePrimary = Color(0xff131214);

  /// socialAppleSecondary figma properties
  /// hex: #1f2224
  /// opacity: 1
  static const Color socialAppleSecondary = Color(0xff1f2224);

  /// socialAppleTertiary figma properties
  /// hex: #2f3133
  /// opacity: 1
  static const Color socialAppleTertiary = Color(0xff2f3133);

  /// socialFacebookPrimary figma properties
  /// hex: #0078ff
  /// opacity: 1
  static const Color socialFacebookPrimary = Color(0xff0078ff);

  /// socialFacebookSecondary figma properties
  /// hex: #0067db
  /// opacity: 1
  static const Color socialFacebookSecondary = Color(0xff0067db);

  /// socialFacebookTertiary figma properties
  /// hex: #0056b8
  /// opacity: 1
  static const Color socialFacebookTertiary = Color(0xff0056b8);

  /// socialTwitterPrimary figma properties
  /// hex: #1da1f2
  /// opacity: 1
  static const Color socialTwitterPrimary = Color(0xff1da1f2);

  /// socialTwitterSecondary figma properties
  /// hex: #0c90e1
  /// opacity: 1
  static const Color socialTwitterSecondary = Color(0xff0c90e1);

  /// socialTwitterTertiary figma properties
  /// hex: #0b84cf
  /// opacity: 1
  static const Color socialTwitterTertiary = Color(0xff0b84cf);

  /// socialGooglePrimary figma properties
  /// hex: #f4f6f7
  /// opacity: 1
  static const Color socialGooglePrimary = Color(0xfff4f6f7);

  /// socialGoogleSecondary figma properties
  /// hex: #e8ebeb
  /// opacity: 1
  static const Color socialGoogleSecondary = Color(0xffe8ebeb);

  /// socialGoogleTertiary figma properties
  /// hex: #daddde
  /// opacity: 1
  static const Color socialGoogleTertiary = Color(0xffdaddde);
}
