bool checkDateConditions(DateTime date) {
  DateTime now = DateTime.now();
  if (date.weekday == DateTime.sunday) {
    return true;
  } else if (date.weekday == DateTime.saturday) {
    if (now.weekday == DateTime.saturday && now.hour < 16) {
      return date.isAfter(now) &&
          (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday ||
              date.weekday == DateTime.monday);
    } else {
      return (date.weekday == DateTime.sunday ||
              date.weekday == DateTime.monday ||
              date.weekday == DateTime.tuesday) &&
          date.isAfter(now);
    }
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day) {
    return true;
  } else {
    if (date.year != now.year ||
        date.month != now.month ||
        date.day != now.day + 1) {
      return false; // Not the next day after the current date
    }

    if (now.hour >= 16) {
      return true; // Already past 4 PM
    }
    return false;
  }
}

DateTime getInitialDate() {
  DateTime now = DateTime.now();

  if (now.hour >= 16) {
    return DateTime.now().add(const Duration(days: 2));
  } else {
    return DateTime.now().add(const Duration(days: 1));
  }
}
