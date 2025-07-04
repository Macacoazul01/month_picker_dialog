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
/// `onYearSelected:` the function that triggers after the user selected an year (default is `null`).
///
Future<int?> showYearPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? headerTitle,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
  Function(int)? onYearSelected,
}) async {
  final DateTime? monthPickerDate = await showMonthPicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableYearPredicate: selectableYearPredicate,
      yearStylePredicate: yearStylePredicate,
      headerTitle: headerTitle,
      monthPickerDialogSettings: monthPickerDialogSettings,
      onlyYear: true,
      onYearSelected: onYearSelected);

  return monthPickerDate?.year;
}
