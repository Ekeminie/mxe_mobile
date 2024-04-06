import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.vm.dart';

class SchedulePaymentViewModel extends BaseViewModel {
  ValueNotifier<EScheduleType?> scheduleType = ValueNotifier(null);

  setSchedule(EScheduleType v) {
    scheduleType.value = v;
    notifyListeners();
  }

  List<String> generateFormattedDates() {
    List<String> formattedDates = [];
    DateTime currentDate = DateTime.now();

    // Find the nearest Saturday (7 days later)
    DateTime nextSaturday =
        currentDate.add(Duration(days: 7 - currentDate.weekday));
    formattedDates.add(_formatDate(nextSaturday));

    // Find the nearest Saturday after 21 days
    DateTime nextSaturdayAfter21Days = nextSaturday.add(Duration(days: 7));

    // Add nextSaturdayAfter21Days repeatedly until we have 5 dates
    while (formattedDates.length < 4) {
      formattedDates.add(_formatDate(nextSaturdayAfter21Days));
      nextSaturdayAfter21Days = nextSaturdayAfter21Days.add(Duration(days: 21));
    }
    return formattedDates;
  }

  List<String> get formattedDates => generateFormattedDates();
  // print(formattedDates);

  String _formatDate(DateTime date) {
    final formatter = DateFormat('d MMMM', 'en_US');
    return formatter.format(date);
  }
}
