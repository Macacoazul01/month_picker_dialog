import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

/// Displays month picker dialog.
///
/// `initialRangeDate:` initial selected date of the months range.
///
/// `endRangeDate:` latest selected date of the months range.
///
/// `firstDate:` optional lower bound for month selection.
///
/// `lastDate:` optional upper bound for month selection.
///
/// `selectableMonthPredicate:` control enabled months just like the official selectableDayPredicate.
///
/// `selectableYearPredicate:` control enabled months just like the official selectableDayPredicate.
///
/// `monthStylePredicate:` individually customize each month.
///
/// `yearStylePredicate:` individually customize each year.
///
/// `headerTitle:` adds a custom title to the header of the dialog (default is `null`).
///
/// `monthPickerDialogSettings:` holds all the style of the picker dialog (default is `defaultMonthPickerDialogSettings`).
///
/// `rangeList:` defines if the controller will return the full list of months between the two selected or only them (default is `false`).
///
Future<List<DateTime>?> showMonthRangePicker({
  required BuildContext context,
  DateTime? initialRangeDate,
  DateTime? endRangeDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(DateTime)? selectableMonthPredicate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? headerTitle,
  bool rangeList = false,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
}) async {
  final ThemeData theme = Theme.of(context);
  final MonthpickerController controller = MonthpickerController(
    initialRangeDate: initialRangeDate.firstDayOfMonth(),
    endRangeDate: endRangeDate.firstDayOfMonth(),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableMonthPredicate: selectableMonthPredicate,
    selectableYearPredicate: selectableYearPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    theme: theme,
    useMaterial3: theme.useMaterial3,
    headerTitle: headerTitle,
    rangeMode: true,
    rangeList: rangeList,
    monthPickerDialogSettings: monthPickerDialogSettings,
  );
  controller.initialize();
  final List<DateTime>? dialogDate = await showDialog<List<DateTime>>(
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
    return [controller.selectedDate];
  }
  return dialogDate;
}
