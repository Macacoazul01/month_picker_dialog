import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

/// Displays month picker dialog.
///
/// `initialDate:` is the initially selected month.
///
/// `firstDate:` is the optional lower bound for month selection.
///
/// `lastDate:` is the optional upper bound for month selection.
///
/// `selectableMonthPredicate:` lets you control enabled months just like the official selectableDayPredicate.
///
/// `selectableYearPredicate:` lets you control enabled years just like the official selectableDayPredicate.
///
/// `monthStylePredicate:` allows you to individually customize each month.
///
/// `yearStylePredicate:` allows you to individually customize each year.
///
/// `confirmWidget:` lets you set a custom confirm widget.
///
/// `cancelWidget:` lets you set a custom cancel widget.
///
/// `customDivider:` lets you add a custom divider between the months/years and the confirm/cancel buttons.
///
/// `headerTitle:` lets you add a custom title to the header of the dialog (default is `null`).
///
/// `monthPickerDialogSettings:` is the object that will hold all of the style of the picker dialog (default is `defaultMonthPickerDialogSettings`).
///
Future<DateTime?> showMonthPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(DateTime)? selectableMonthPredicate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? confirmWidget,
  Widget? cancelWidget,
  Widget? customDivider,
  Widget? headerTitle,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
}) async {
  final ThemeData theme = Theme.of(context);
  final MonthpickerController controller = MonthpickerController(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    monthPickerDialogSettings: monthPickerDialogSettings,
    selectableMonthPredicate: selectableMonthPredicate,
    selectableYearPredicate: selectableYearPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    confirmWidget: confirmWidget,
    cancelWidget: cancelWidget,
    theme: theme,
    useMaterial3: theme.useMaterial3,
    customDivider: customDivider,
    headerTitle: headerTitle,
    rangeMode: false,
    rangeList: false,
  );
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
    return controller.selectedDate;
  }
  return dialogDate;
}
