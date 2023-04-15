import 'package:flutter/material.dart';
import '/src/helpers/controller.dart';
import '/src/helpers/locale_utils.dart';
import '/src/year_selector/year_button.dart';

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
    final String localeString =
        getLocale(context, selectedLocale: controller.locale);
    final theme = Theme.of(context);
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      children: List<Widget>.generate(
        12,
        (final int index) => YearButton(
          theme: theme,
          controller: controller,
          page: page,
          index: index,
          onYearSelected: onYearSelected,
          localeString: localeString,
        ),
      ).toList(growable: false),
    );
  }
}
