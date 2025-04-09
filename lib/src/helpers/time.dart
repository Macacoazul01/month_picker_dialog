class Time {
  int? time;
  int? year;

  Time({this.time, this.year});

  Time copyWith({int? time, int? year}) {
    return Time(
      time: time ?? this.time,
      year: year ?? this.year,
    );
  }
}