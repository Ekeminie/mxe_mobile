import 'package:flutter/material.dart';

enum Status {
  verified(title: "Verified", color: Color(0XFF4FBBA8)),
  pending(title: "Pending", color: Color(0XFFD2A447)),
  unverified(title: "Unverified", color: Colors.grey),
  rejected(title: "Rejected", color: Color(0XFFE86969)),
  review(title: "In review", color: Colors.lightBlueAccent);

  final Color? color;
  final String? title;
  const Status({this.title, this.color});
}

enum IdTypeEnum {
  none(title: ""),
  nin(title: "NIN"),
  internationalPassport(title: "INTERNATIONAL PASSPORT"),
  driversLicense(title: "DRIVER LICENSE");

  final String? title;
  const IdTypeEnum({this.title});
}

extension IdTypeExtension on String {
  IdTypeEnum toIdType() {
    switch (toLowerCase()) {
      case "nin":
        return IdTypeEnum.nin;
      case "international passport":
        return IdTypeEnum.internationalPassport;
      case "driver license":
        return IdTypeEnum.driversLicense;
      default:
        return IdTypeEnum.none;
    }
  }
}

Color color = Colors.lightBlueAccent;

enum InsightsEnum {
  income(title: "Income", color: Color(0XFF0828B1), code: "income"),
  billPayment(
      title: "Bill Payments", color: Color(0XFFFF9175), code: 'bill_payments'),
  transfer(title: "Transfer", color: Color(0xffFFF2B3), code: "Withdrawals"),
  withdrawal(
      title: "Withdrawal", color: Color(0XFF907AFF), code: "Withdrawals");

  final Color? color;
  final String? title;
  final String? code;
  const InsightsEnum({this.title, this.color, this.code});
}

enum InsightsTimeLineEnum {
  sevenDays(title: "Last 7 Day", code: 1, api: "last7days"),
  thirtyDays(title: "Last 39 Days", code: 2, api: "last30days"),
  threeMonths(title: "Last 3 Months", code: 3, api: "last3months"),
  sixMonths(title: "Last 6 Months", code: 4, api: "last6months"),
  oneYear(title: "Last 1 Year", code: 5, api: "last1year"),
  allTime(title: "All Time", code: 6, api: "allTime");

  final num? code;
  final String? title;
  final String? api;
  const InsightsTimeLineEnum({this.title, this.code, this.api});
}
