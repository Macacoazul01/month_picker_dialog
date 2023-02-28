import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '/src/helpers/common.dart';
import '/src/helpers/extensions.dart';
import '/src/month_selector/month_selector.dart';
import '/src/year_selector/year_selector.dart';

class MonthpickerController {
  MonthpickerController({
    required this.initialDate,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    required this.capitalizeFirstLetter,
    this.headerColor,
    this.headerTextColor,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthTextColor,
    this.confirmText,
    this.cancelText,
    this.customHeight,
    this.customWidth,
    required this.yearFirst,
    required this.roundedCornersRadius,
  });

  //User defined variables
  final DateTime? firstDate, lastDate, initialDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter, yearFirst;
  final Color? headerColor,
      headerTextColor,
      selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
  final Text? confirmText, cancelText;
  final double? customHeight, customWidth;
  final double roundedCornersRadius;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();

  final PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject =
      PublishSubject<UpDownPageLimit> ();
  final PublishSubject<UpDownButtonEnableState>
      upDownButtonEnableStatePublishSubject = PublishSubject<UpDownButtonEnableState>();

  DateTime selectedDate = DateTime.now().firstDayOfMonth();
  DateTime? localFirstDate, localLastDate;

  late int yearPageCount, yearItemCount, monthPageCount;

  void initialize() {
    if (initialDate != null) {
      selectedDate = initialDate!.firstDayOfMonth();
    }
    if (firstDate != null)
      localFirstDate = DateTime(firstDate!.year, firstDate!.month);
    if (lastDate != null)
      localLastDate = DateTime(lastDate!.year, lastDate!.month);

    yearItemCount = getYearItemCount(localFirstDate, localLastDate);
    yearPageCount = getYearPageCount(localFirstDate, localLastDate);
    monthPageCount = getMonthPageCount(localFirstDate, localLastDate);
  }

  void dispose() {
    upDownPageLimitPublishSubject.close();
    upDownButtonEnableStatePublishSubject.close();
  }

  void firstPossibleMonth(int year) {
    if (selectableMonthPredicate != null) {
      for (int i = 1; i <= 12; i++) {
        final DateTime mes = DateTime(year, i);
        if (selectableMonthPredicate!(mes)) {
          selectedDate = mes;
          break;
        }
      }
    } else {
      selectedDate = DateTime(year);
    }
  }

//Pages count
  int getYearPageCount(DateTime? firstDate, DateTime? lastDate) {
    if (firstDate != null && lastDate != null) {
      if (lastDate.year - firstDate.year <= 12)
        return 1;
      else
        return ((lastDate.year - firstDate.year + 1) / 12).ceil();
    } else if (firstDate != null && lastDate == null) {
      return (yearItemCount / 12).ceil();
    } else if (firstDate == null && lastDate != null) {
      return (yearItemCount / 12).ceil();
    } else
      return (9999 / 12).ceil();
  }

  int getYearItemCount(DateTime? firstDate, DateTime? lastDate) {
    if (firstDate != null && lastDate != null) {
      return lastDate.year - firstDate.year + 1;
    } else if (firstDate != null && lastDate == null) {
      return 9999 - firstDate.year;
    } else if (firstDate == null && lastDate != null) {
      return lastDate.year;
    } else
      return 9999;
  }

  int getMonthPageCount(DateTime? firstDate, DateTime? lastDate) {
    if (firstDate != null && lastDate != null) {
      return lastDate.year - firstDate.year + 1;
    } else if (firstDate != null && lastDate == null) {
      return 9999 - firstDate.year;
    } else if (firstDate == null && lastDate != null) {
      return lastDate.year + 1;
    } else
      return 9999;
  }

  void cancelFunction(BuildContext context) {
    Navigator.pop(context, null);
  }

  void okFunction(BuildContext context) {
    Navigator.pop(context, selectedDate);
  }
}
