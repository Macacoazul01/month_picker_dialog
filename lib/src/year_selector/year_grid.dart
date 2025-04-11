import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

///The year grid. It has all of the avaliable options to be selected.
class YearGrid extends StatelessWidget {
  const YearGrid({
    super.key,
    required this.page,
    required this.onYearSelected,
    required this.controller,
  });
  final int page;
  final ValueChanged<int> onYearSelected;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final String localeString = getLocale(context,
        selectedLocale:
            controller.monthPickerDialogSettings.dialogSettings.locale);
    return ValueListenableBuilder(valueListenable: controller.selectedDate, builder: (context, value, child) {
      return GridView.count(
        physics:
        controller.monthPickerDialogSettings.dialogSettings.blockScrolling
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        children: List<Widget>.generate(
          12,
              (final int index) => YearButton(
            theme: controller.theme,
            controller: controller,
            page: page,
            index: index,
            selectDate: value,
            onYearSelected: onYearSelected,
            localeString: localeString,
          ),
        ).toList(growable: false),
      );
    },);

  }
}
