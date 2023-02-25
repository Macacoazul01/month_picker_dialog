import 'package:flutter/material.dart';
import '/src/helpers/locale_utils.dart';

import 'month_button.dart';

class MonthYearGridBuilder extends StatelessWidget {
  const MonthYearGridBuilder(
      {super.key,
      required this.onMonthSelected,
      this.firstDate,
      this.lastDate,
      required this.selectedDate,
      required this.openDate,
      this.locale,
      this.selectableMonthPredicate,
      required this.capitalizeFirstLetter,
      this.selectedMonthBackgroundColor,
      this.selectedMonthTextColor,
      this.unselectedMonthTextColor,
      required this.page});
  final ValueChanged<DateTime> onMonthSelected;
  final DateTime? firstDate, lastDate;
  final DateTime selectedDate, openDate;
  final Locale? locale;
  final bool Function(DateTime)? selectableMonthPredicate;
  final bool capitalizeFirstLetter;
  final Color? selectedMonthBackgroundColor,
      selectedMonthTextColor,
      unselectedMonthTextColor;
  final int page;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      children: List<Widget>.generate(
        12,
        (final int index) => MonthButton(
          openDate: openDate,
          selectedDate: selectedDate,
          theme: Theme.of(context),
          date: DateTime(
              firstDate != null ? firstDate!.year + page : page, index + 1),
          locale: getLocale(context, selectedLocale: locale),
          capitalizeFirstLetter: capitalizeFirstLetter,
          selectedMonthBackgroundColor: selectedMonthBackgroundColor,
          selectedMonthTextColor: selectedMonthTextColor,
          unselectedMonthTextColor: unselectedMonthTextColor,
          onMonthSelected: onMonthSelected,
          firstDate: firstDate,
          lastDate: lastDate,
          selectableMonthPredicate: selectableMonthPredicate,
        ),
      ).toList(growable: false),
    );
  }
}
