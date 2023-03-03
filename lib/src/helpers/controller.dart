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
    this.confirmWidget,
    this.cancelWidget,
    this.customHeight,
    this.customWidth,
    required this.yearFirst,
    required this.roundedCornersRadius,
    required this.forceSelectedDate,
  });

  //User defined variables
  final DateTime? firstDate, lastDate, initialDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter, yearFirst, forceSelectedDate;
  final Color? headerColor,
      headerTextColor,
      selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
  final Widget? confirmWidget, cancelWidget;
  final double? customHeight, customWidth;
  final double roundedCornersRadius;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();

  final PublishSubject<UpDownPageLimit> yearupDownPageLimitPublishSubject =
      PublishSubject<UpDownPageLimit>();
  final PublishSubject<UpDownPageLimit> monthupDownPageLimitPublishSubject =
      PublishSubject<UpDownPageLimit>();
  final PublishSubject<UpDownButtonEnableState>
      yearupDownButtonEnableStatePublishSubject =
      PublishSubject<UpDownButtonEnableState>();
  final PublishSubject<UpDownButtonEnableState>
      monthupDownButtonEnableStatePublishSubject =
      PublishSubject<UpDownButtonEnableState>();

  DateTime selectedDate = DateTime.now().firstDayOfMonth();
  DateTime? localFirstDate, localLastDate;

  late int yearPageCount, yearItemCount, monthPageCount;

  PageController? yearPageController, monthPageController;

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
    yearPageController?.dispose();
    monthPageController?.dispose();
    yearupDownPageLimitPublishSubject.close();
    yearupDownButtonEnableStatePublishSubject.close();
    monthupDownPageLimitPublishSubject.close();
    monthupDownButtonEnableStatePublishSubject.close();
  }

  //get first possible month after selecting a year
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

  //selector functions
  void cancelFunction(BuildContext context) {
    Navigator.pop(context, null);
  }

  void okFunction(BuildContext context) {
    Navigator.pop(context, selectedDate);
  }

  //Header functions
  void onUpButtonPressed() {
    if (yearSelectorState.currentState != null) {
      yearSelectorState.currentState!.goUp();
    } else {
      monthSelectorState.currentState!.goUp();
    }
  }

  void onDownButtonPressed() {
    if (yearSelectorState.currentState != null) {
      yearSelectorState.currentState!.goDown();
    } else {
      monthSelectorState.currentState!.goDown();
    }
  }
}
