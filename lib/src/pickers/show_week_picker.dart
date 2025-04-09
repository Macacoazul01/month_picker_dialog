import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/time.dart';
import '/month_picker_dialog.dart';

/// Displays month picker dialog.
///
/// `initialDate:` the initially selected month.
///
/// `firstDate:` the optional lower bound for month selection.
///
/// `lastDate:` the optional upper bound for month selection.
///
/// `selectableMonthPredicate:` control enabled months just like the official selectableDayPredicate.
///
/// `selectableYearPredicate:` control enabled years just like the official selectableDayPredicate.
///
/// `monthStylePredicate:` individually customize each month.
///
/// `yearStylePredicate:` individually customize each year.
///
/// `headerTitle:` add a custom title to the header of the dialog (default is `null`).
///
/// `monthPickerDialogSettings:` holds all the style of the picker dialog (default is `defaultMonthPickerDialogSettings`).
///
/// `onlyYear:` Displays only year picker dialog. Prefer to use `showYearPicker` instead of `showMonthPicker` with this parameter set to `true` to avoid unnecessary parameters.
///
Future<Time?> showWeekPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Time? initTime,
  bool isWeek =true,
  bool Function(DateTime)? selectableMonthPredicate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? headerTitle,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
  bool onlyYear = false,
}) async {
  final ThemeData theme = Theme.of(context);
  final MonthpickerController controller = MonthpickerController(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    initTime: initTime,
    monthPickerDialogSettings: monthPickerDialogSettings,
    selectableMonthPredicate: selectableMonthPredicate,
    selectableYearPredicate: selectableYearPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    isWeek: isWeek,
    theme: theme,
    useMaterial3: theme.useMaterial3,
    headerTitle: headerTitle,
    onlyYear: onlyYear,
  );
  controller.initialize();
  final DateTime? dialogDate = await showDialog<DateTime?>(
    context: context,
    barrierDismissible: monthPickerDialogSettings.dialogSettings.dismissible,
    builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: YearUpDownPageProvider(),
          ),
          ChangeNotifierProvider.value(
            value: MonthUpDownPageProvider(),
          ),
        ],
        child: MonthPickerDialog(controller: controller),
      );
    },
  );
  if (monthPickerDialogSettings.dialogSettings.dismissible &&
      monthPickerDialogSettings.dialogSettings.forceSelectedDate &&
      dialogDate == null) {
    return controller.selectWeek;
  }
  return controller.selectWeek;
}