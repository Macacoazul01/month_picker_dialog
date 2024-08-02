import 'package:flutter/material.dart';

import '/month_picker_dialog.dart';

/// Displays only year picker dialog.
///
/// `initialDate:` is the initially selected month.
///
/// `firstDate:` is the optional lower bound for month selection.
///
/// `lastDate:` is the optional upper bound for month selection.
///
/// `selectableYearPredicate:` lets you control enabled years just like the official selectableDayPredicate.
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
Future<int?> showYearPicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Widget? confirmWidget,
  Widget? cancelWidget,
  Widget? customDivider,
  Widget? headerTitle,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
}) async {
  final DateTime? monthPickerDate = await showMonthPicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    selectableYearPredicate: selectableYearPredicate,
    yearStylePredicate: yearStylePredicate,
    confirmWidget: confirmWidget,
    cancelWidget: cancelWidget,
    customDivider: customDivider,
    headerTitle: headerTitle,
    monthPickerDialogSettings: monthPickerDialogSettings,
    onlyYear: true,
  );

  return monthPickerDate?.year;
}
