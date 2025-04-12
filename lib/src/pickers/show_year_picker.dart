import 'package:flutter/material.dart';

import '/month_picker_dialog.dart';

/// Displays only year picker dialog.
///
/// `initialDate:` initially selected month.
///
/// `firstDate:` optional lower bound for month selection.
///
/// `lastDate:` optional upper bound for month selection.
///
/// `selectableYearPredicate:` control enabled years just like the official selectableDayPredicate.
///
/// `yearStylePredicate:` individually customize each year.
///
/// `headerTitle:` adds a custom title to the header of the dialog (default is `null`).
///
/// `monthPickerDialogSettings:` holds all the style of the picker dialog (default is `defaultMonthPickerDialogSettings`).
///
Future<int?> showYearPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String? textToday,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? headerTitle,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
}) async {
  final DateTime? monthPickerDate = await showMonthPicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    textToday:textToday,
    selectableYearPredicate: selectableYearPredicate,
    yearStylePredicate: yearStylePredicate,
    headerTitle: headerTitle,
    monthPickerDialogSettings: monthPickerDialogSettings,
    onlyYear: true,
  );

  return monthPickerDate?.year;
}
