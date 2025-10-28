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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            controller.monthPickerDialogSettings.dialogSettings.gridPadding,
        crossAxisCount: 4,
        children: List<Widget>.generate(
          controller.monthPickerDialogSettings.dialogSettings.yearsPerPage,
          (final int index) => YearButton(
            theme: controller.theme,
            controller: controller,
            page: page,
            index: index,
            onYearSelected: onYearSelected,
            localeString: localeString,
          ),
        ).toList(growable: false),
      ),
    );
  }
}
