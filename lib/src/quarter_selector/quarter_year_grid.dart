import 'package:flutter/material.dart';
import 'package:month_picker_dialog/src/helpers/time.dart';
import 'package:month_picker_dialog/src/quarter_selector/quarter_button.dart';
import 'package:month_picker_dialog/src/week_selector/week_button.dart';

import '/month_picker_dialog.dart';

///The month grid. It has all of the avaliable options to be selected.
class QuarterYearGridBuilder extends StatelessWidget {
  const QuarterYearGridBuilder({
    super.key,
    required this.onQuarterSelected,
    required this.controller,
  });
  final ValueChanged<Time> onQuarterSelected;
  final MonthpickerController controller;
  @override
  Widget build(BuildContext context) {
    final String localeString = getLocale(context,
        selectedLocale:
        controller.monthPickerDialogSettings.dialogSettings.locale);
    return GridView.count(
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      children: List<Widget>.generate(
        4,
            (final int index) => QuarterButton(
          theme: controller.theme,
          controller: controller,
          index: index,
           onQuarterSelected: onQuarterSelected,
          localeString: localeString,
        ),
      ).toList(growable: false),
    );
  }
}
