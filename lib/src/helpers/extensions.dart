extension MyDateExtension on DateTime {
  DateTime firstDayOfMonth(){
    return DateTime(this.year, this.month);
  }
}