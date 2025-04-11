import 'package:flutter/material.dart';
import 'package:month_picker_dialog/src/helpers/time.dart';
import 'package:month_picker_dialog/src/week_selector/week_button.dart';

import '/month_picker_dialog.dart';

///The month grid. It has all of the avaliable options to be selected.
class WeekYearGridBuilder extends StatelessWidget {
  const WeekYearGridBuilder({
    super.key,
    required this.onWeekSelected,
    required this.controller,
  });

  final ValueChanged<Time> onWeekSelected;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final String localeString = getLocale(context, selectedLocale: controller.monthPickerDialogSettings.dialogSettings.locale);
    return ValueListenableBuilder(
      valueListenable: controller.selectWeek,
      builder: (context, value, child) {
        return GridView.count(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          crossAxisCount: 7,
          physics: NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(
            52,
            (final int index) => WeekButton(
              theme: controller.theme,
              controller: controller,
              index: index,
              onWeekSelected: onWeekSelected,
              localeString: localeString,
              selectWeek: value.time,
            ),
          ).toList(growable: false),
        );
      },
    );
  }
}
