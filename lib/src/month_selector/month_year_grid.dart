import 'package:flutter/material.dart';

import '/month_picker_dialog.dart';

///The month grid. It has all of the avaliable options to be selected.
class MonthYearGridBuilder extends StatelessWidget {
  const MonthYearGridBuilder({
    super.key,
    required this.onMonthSelected,
    required this.controller,
    required this.page,
  });
  final ValueChanged<DateTime> onMonthSelected;
  final MonthpickerController controller;
  final int page;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: controller.monthPickerDialogSettings.dialogSettings.blockScrolling
          ? const NeverScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      children: List<Widget>.generate(
        12,
        (final int index) => MonthButton(
          theme: controller.theme,
          
          date: DateTime(
              controller.localFirstDate != null
                  ? controller.localFirstDate!.year + page
                  : page,
              index + 1),
          localeString: getLocale(context,
              selectedLocale:
                  controller.monthPickerDialogSettings.dialogSettings.locale),
          onMonthSelected: onMonthSelected,
          controller: controller,
        ),
      ).toList(growable: false),
    );
  }
}
