import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/month_picker_dialog.dart';

///Global controller of the dialog. It holds the initial parameters passed on the widget creation.
class MonthpickerController {
  MonthpickerController({
    this.initialDate,
    this.initialRangeDate,
    this.endRangeDate,
    this.firstDate,
    this.lastDate,
    this.selectableMonthPredicate,
    this.selectableYearPredicate,
    this.monthStylePredicate,
    this.yearStylePredicate,
    required this.theme,
    required this.useMaterial3,
    this.headerTitle,
    this.rangeMode = false,
    this.rangeList = false,
    required this.monthPickerDialogSettings,
    this.onlyYear = false,
    this.onMonthSelected,
    this.onYearSelected,
    this.returnToStartofRange = false,
  });

  //User defined variables
  final ThemeData theme;
  final DateTime? firstDate, lastDate, initialDate;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool Function(int)? selectableYearPredicate;
  final ButtonStyle? Function(DateTime)? monthStylePredicate;
  final ButtonStyle? Function(int)? yearStylePredicate;
  final bool useMaterial3, rangeMode, rangeList, onlyYear, returnToStartofRange;
  final Widget? headerTitle;
  final MonthPickerDialogSettings monthPickerDialogSettings;
  final Function(DateTime)? onMonthSelected;
  final Function(int)? onYearSelected;

  //local variables
  final GlobalKey<YearSelectorState> yearSelectorState = GlobalKey();
  final GlobalKey<MonthSelectorState> monthSelectorState = GlobalKey();
  final DateTime now = DateTime.now().firstDayOfMonth()!;

  late DateTime selectedDate;
  DateTime? localFirstDate, localLastDate, initialRangeDate, endRangeDate;

  late int yearPageCount, yearItemCount, monthPageCount;

  PageController? yearPageController, monthPageController;

  int startOfRangePage = 0;

  ///Function to initialize the controller when the dialog is created.
  void initialize() {
    selectedDate = (initialRangeDate ?? initialDate ?? now).firstDayOfMonth()!;
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
    if (initialRangeDate != null) {
      if (endRangeDate == null) {
        return [initialRangeDate!];
      }

      if (initialRangeDate == endRangeDate) {
        return [initialRangeDate!];
      }

      final DateTime startDate = initialRangeDate!;
      final DateTime endDate = endRangeDate!;
      if (rangeList) {
        return rangeListCreation(startDate, endDate);
      }
      return [startDate, endDate];
    } else {
      if (endRangeDate != null) {
        return [endRangeDate!];
      }
    }
    return [];
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
    if (initialRangeDate == null) {
      initialRangeDate = time;
      _updateStartOfRangePage();
    } else if (initialRangeDate != null && endRangeDate == null) {
      if (time.isBefore(initialRangeDate!)) {
        endRangeDate = initialRangeDate;
        initialRangeDate = time;
        _updateStartOfRangePage();
      } else {
        endRangeDate = time;
      }
      if ((monthPageController?.page ?? 0).toInt() != startOfRangePage &&
          returnToStartofRange) {
        monthPageController?.animateToPage(
          startOfRangePage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.decelerate,
        );
      }
    } else {
      initialRangeDate = time;
      _updateStartOfRangePage();
      endRangeDate = null;
    }
  }

  void _updateStartOfRangePage() {
    startOfRangePage = (monthPageController?.page ?? 0).toInt();
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
      if (initialRangeDate != null) {
        if (monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter) {
          rangeDateString =
              '${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(initialRangeDate!))}';
        } else {
          rangeDateString = DateFormat.yMMM(localeString)
              .format(initialRangeDate!)
              .toLowerCase();
        }
      }

      if (endRangeDate != null) {
        if (monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter) {
          rangeDateString +=
              ' - ${toBeginningOfSentenceCase(DateFormat.yMMM(localeString).format(endRangeDate!))}';
        } else {
          rangeDateString +=
              ' - ${DateFormat.yMMM(localeString).format(initialRangeDate!).toLowerCase()}';
        }
      }
      return rangeDateString;
    }
  }
}
