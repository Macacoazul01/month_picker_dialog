import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/month_picker_dialog.dart';

///The widget that presents the current selected date on the header.
class HeaderSelectedDate extends StatelessWidget {
  const HeaderSelectedDate({
    super.key,
    required this.theme,
    required this.localeString,
    required this.controller,
  });

  final ThemeData theme;
  final String localeString;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final MonthUpDownPageProvider monthUpDownPageProvider = Provider.of<MonthUpDownPageProvider>(context);

    final YearUpDownPageProvider yearProvider = Provider.of<YearUpDownPageProvider>(context);
    return Text(
      textAlign: TextAlign.center,
      (controller.isQuarter || controller.isWeek)
          ? DateFormat.y(localeString).format(DateTime(yearProvider.pageLimit.upLimit))
          : controller.onlyYear
              ? '${DateFormat.y(localeString).format(DateTime(yearProvider.pageLimit.upLimit))} - ${DateFormat.y(localeString).format(DateTime(yearProvider.pageLimit.downLimit))}'
              : DateFormat.y(localeString).format(DateTime(monthUpDownPageProvider.pageLimit.upLimit)),
      textScaler: controller.monthPickerDialogSettings.dialogSettings.textScaleFactor != null
          ? TextScaler.linear(controller.monthPickerDialogSettings.dialogSettings.textScaleFactor!)
          : null,
      style: controller.monthPickerDialogSettings.headerSettings.headerSelectedIntervalTextStyle ?? theme.primaryTextTheme.titleMedium,
    );
  }
}
