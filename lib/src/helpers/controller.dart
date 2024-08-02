import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/month_picker_dialog.dart';

///Global controller of the dialog. It holds the initial parameters passed on the widget creation.
class MonthpickerController {
  MonthpickerController({
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableMonthPredicate,
    this.selectableYearPredicate,
    this.monthStylePredicate,
    this.yearStylePredicate,
    this.confirmWidget,
    this.cancelWidget,
    required this.theme,
    required this.useMaterial3,
    this.customDivider,
    this.headerTitle,
    this.rangeMode = false,
    this.rangeList = false,
    required this.monthPickerDialogSettings,
    this.onlyYear = false,
  });

  //User defined variables
  final ThemeData theme;
  final DateTime? firstDate, lastDate, initialDate;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool Function(int)? selectableYearPredicate;
  final ButtonStyle? Function(DateTime)? monthStylePredicate;
  final ButtonStyle? Function(int)? yearStylePredicate;
  final bool useMaterial3, rangeMode, rangeList, onlyYear;
  final Widget? confirmWidget, cancelWidget, customDivider;
  final Widget? headerTitle;
  final MonthPickerDialogSettings monthPickerDialogSettings;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();
  final DateTime now = DateTime.now().firstDayOfMonth();

  late DateTime selectedDate;
  DateTime? localFirstDate, localLastDate, firstRangeDate, secondRangeDate;

  late int yearPageCount, yearItemCount, monthPageCount;

  PageController? yearPageController, monthPageController;

  ///Function to initialize the controller when the dialog is created.
  void initialize() {
    if (initialDate != null) {
      selectedDate = initialDate!.firstDayOfMonth();
    } else {
      selectedDate = now;
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
      if (lastDate.year - firstDate.year <= 12) {
        return 1;
      } else {
        return ((lastDate.year - firstDate.year + 1) / 12).ceil();
      }
    } else if (firstDate != null && lastDate == null) {
      return (yearItemCount / 12).ceil();
    } else if (firstDate == null && lastDate != null) {
      return (yearItemCount / 12).ceil();
    } else {
      return (9999 / 12).ceil();
    }
  }

  ///year item count
  int getYearItemCount(DateTime? firstDate, DateTime? lastDate) {
    if (firstDate != null && lastDate != null) {
      return lastDate.year - firstDate.year + 1;
    } else if (firstDate != null && lastDate == null) {
      return 9999 - firstDate.year;
    } else if (firstDate == null && lastDate != null) {
      return lastDate.year;
    } else {
      return 9999;
    }
  }

  ///month pages count
  int getMonthPageCount(DateTime? firstDate, DateTime? lastDate) {
    if (firstDate != null && lastDate != null) {
      return lastDate.year - firstDate.year + 1;
    } else if (firstDate != null && lastDate == null) {
      return 9999 - firstDate.year;
    } else if (firstDate == null && lastDate != null) {
      return lastDate.year + 1;
    } else {
      return 9999;
    }
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
      Navigator.pop(context, selectRange());
    }
  }

  ///function to return the range of selected months
  List<DateTime> selectRange() {
    if (firstRangeDate != null && secondRangeDate != null) {
      if (firstRangeDate == secondRangeDate) {
        return [firstRangeDate!];
      }

      final DateTime startDate = firstRangeDate!;
      final DateTime endDate = secondRangeDate!;

      if (rangeList) {
        return rangeListCreation(startDate, endDate);
      } else {
        // secondRangeDate = DateTime(secondRangeDate!.year, secondRangeDate!.month + 1).subtract(Duration(days: 1));
        return [startDate, endDate];
      }
    } else {
      return [];
    }
  }

  ///function to return the full list range of selected months
  List<DateTime> rangeListCreation(DateTime startDate, DateTime endDate) {
    final List<DateTime> monthsList = [];

    while (startDate.isBefore(endDate)) {
      monthsList.add(startDate);
      startDate = DateTime(startDate.year, startDate.month + 1);
    }

    monthsList.add(startDate);
    return monthsList;
  }

  // function to select a range between months
  void onRangeDateSelect(DateTime time) {
    if (firstRangeDate == null) {
      firstRangeDate = time;
    } else if (firstRangeDate != null && secondRangeDate == null) {
      if (time.isBefore(firstRangeDate!)) {
        secondRangeDate = firstRangeDate;
        firstRangeDate = time;
      } else {
        secondRangeDate = time;
      }
    } else {
      firstRangeDate = time;
      secondRangeDate = null;
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

  ///function to show datetime in header
  String getDateTimeHeaderText(String localeString) {
    if (!rangeMode) {
      if (!onlyYear) {
        if (monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter) {
          return '${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(selectedDate))}';
        }
        return DateFormat.yMMM(localeString).format(selectedDate).toLowerCase();
      } else {
        return DateFormat.y(localeString).format(selectedDate);
      }
    } else {
      String rangeDateString = "";
      if (firstRangeDate != null) {
        if (monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter) {
          rangeDateString =
              '${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(firstRangeDate!))}';
        } else {
          rangeDateString = DateFormat.yMMM(localeString)
              .format(firstRangeDate!)
              .toLowerCase();
        }
      }

      if (secondRangeDate != null) {
        if (monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter) {
          rangeDateString +=
              ' - ${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(secondRangeDate!))}';
        } else {
          rangeDateString +=
              ' - ${DateFormat.yMMM(localeString).format(firstRangeDate!).toLowerCase()}';
        }
      }
      return rangeDateString;
    }
  }
}
