///Extension on DateTime to get the first day of month
extension MyDateExtension on DateTime? {
  DateTime? firstDayOfMonth() {
    if (this != null) {
      return DateTime(this!.year, this!.month);
    }
    return null;
  }

  DateTime? lastDayOfMonth() {
    if (this != null) {
      return DateTime(this!.year, this!.month + 1, 0);
    }
    return null;
  }
}

extension NullableDateTimeExtension on DateTime? {
  bool isBetween(DateTime start, DateTime end) {
    if (this == null) {
      return false;
    } else {
      return this!.compareTo(start) >= 0 && this!.compareTo(end) <= 0;
    }
  }

  bool nullableIsBefore(DateTime end) {
    if (this == null) {
      return false;
    } else {
      return this!.compareTo(end) < 0;
    }
  }

}

int getCurrentWeekNumber() {
  final now = DateTime.now();
  final firstDayOfYear = DateTime(now.year, 1, 1);
  final daysPassed = now.difference(firstDayOfYear).inDays;

  // ISO 8601: tuần bắt đầu từ Thứ Hai
  final weekNumber = ((daysPassed + firstDayOfYear.weekday) / 7).ceil();
  return weekNumber;
}

int getCurrentQuarter() {
  final currentMonth = DateTime.now().month;
  return ((currentMonth - 1) ~/ 3) + 1;
}