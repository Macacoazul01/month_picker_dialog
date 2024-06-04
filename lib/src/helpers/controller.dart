import 'package:flutter/material.dart';

import '/month_picker_dialog.dart';

///Global controller of the dialog. It holds the initial parameters passed on the widget creation.
class MonthpickerController {
  MonthpickerController({
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.selectableMonthPredicate,
    this.monthStylePredicate,
    this.yearStylePredicate,
    required this.capitalizeFirstLetter,
    this.headerColor,
    this.headerTextColor,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthTextColor,
    this.currentMonthTextColor,
    required this.selectedMonthPadding,
    this.backgroundColor,
    this.confirmWidget,
    this.cancelWidget,
    this.customHeight,
    required this.customWidth,
    required this.yearFirst,
    required this.roundedCornersRadius,
    required this.forceSelectedDate,
    required this.animationMilliseconds,
    required this.hideHeaderRow,
    required this.theme,
    required this.useMaterial3,
    this.textScaleFactor,
    this.arrowSize,
    required this.forcePortrait,
    this.customDivider,
    required this.blockScrolling,
    required this.dialogBorderSide,
    required this.buttonBorder,
    required this.headerTitle,
    required this.rangeMode,
  });

  //User defined variables
  final ThemeData theme;
  final DateTime? firstDate, lastDate, initialDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final ButtonStyle? Function(DateTime)? monthStylePredicate;
  final ButtonStyle? Function(int)? yearStylePredicate;
  final bool capitalizeFirstLetter,
      yearFirst,
      forceSelectedDate,
      hideHeaderRow,
      useMaterial3,
      forcePortrait,
      blockScrolling,
      rangeMode;
  final Color? headerColor,
      headerTextColor,
      selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor,
      backgroundColor,
      currentMonthTextColor;
  final Widget? confirmWidget, cancelWidget, customDivider;
  final double? customHeight, textScaleFactor, arrowSize;
  final double roundedCornersRadius, selectedMonthPadding, customWidth;
  final int animationMilliseconds;
  final BorderSide dialogBorderSide;
  final OutlinedBorder buttonBorder;
  final Widget? headerTitle;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();

  DateTime selectedDate = DateTime.now().firstDayOfMonth();
  DateTime? localFirstDate, localLastDate, firstRangeDate, secondRangeDate;

  late int yearPageCount, yearItemCount, monthPageCount;

  PageController? yearPageController, monthPageController;

  ///Function to initialize the controller when the dialog is created.
  void initialize() {
    if (initialDate != null) {
      selectedDate = initialDate!.firstDayOfMonth();
    }
    if (firstDate != null) {
      localFirstDate = DateTime(firstDate!.year, firstDate!.month);
    }

    if (lastDate != null) {
      localLastDate = DateTime(lastDate!.year, lastDate!.month);
    }

    yearItemCount = getYearItemCount(localFirstDate, localLastDate);
    yearPageCount = getYearPageCount(localFirstDate, localLastDate);
    monthPageCount = getMonthPageCount(localFirstDate, localLastDate);
  }

  ///Function to dispose year and month pages when the dialog closes.
  void dispose() {
    yearPageController?.dispose();
    monthPageController?.dispose();
  }

  /// function to get first possible month after selecting a year
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

  ///year pages count
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

  ///year item count
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

  ///month pages count
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
  ///function to cancel selecting a month
  void cancelFunction(BuildContext context) {
    Navigator.pop(context);
  }

  ///function to confirm selecting a month
  void okFunction(BuildContext context) {
    if (!rangeMode) {
      Navigator.pop(context, selectedDate);
    } else {
      Navigator.pop(context, rangeListCreation());
    }
  }

  ///function to return the range of selected months
  List<DateTime> rangeListCreation() {
    if (firstRangeDate != null && secondRangeDate != null) {
      final List<DateTime> firstDays = [];

      // Se as datas forem iguais, adicione à lista
      if (firstRangeDate == secondRangeDate) {
        firstDays.add(firstRangeDate!);
        return firstDays;
      }

      late DateTime startDate;
      late final DateTime endDate;
      if (firstRangeDate!.isBefore(secondRangeDate!)) {
        startDate = firstRangeDate!;
        endDate = secondRangeDate!;
      } else {
        startDate = secondRangeDate!;
        endDate = firstRangeDate!;
      }

      while (startDate.isBefore(endDate)) {
        firstDays.add(startDate);
        startDate = DateTime(startDate.year, startDate.month + 1, 1);
      }

      return firstDays;
    } else {
      return [];
    }
  }

  //Header functions
  ///function to move the page when up header button is pressed
  void onUpButtonPressed() {
    if (yearSelectorState.currentState != null) {
      yearSelectorState.currentState!.goUp();
    } else {
      monthSelectorState.currentState!.goUp();
    }
  }

  ///function to move the page when down header button is pressed
  void onDownButtonPressed() {
    if (yearSelectorState.currentState != null) {
      yearSelectorState.currentState!.goDown();
    } else {
      monthSelectorState.currentState!.goDown();
    }
  }
}
