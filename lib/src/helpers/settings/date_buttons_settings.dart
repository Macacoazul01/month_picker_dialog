import 'package:flutter/widgets.dart';

///Class to hold all the customizations of the buttons part of the package.
class PickerDateButtonsSettings {
  const PickerDateButtonsSettings({
    this.monthTextStyle,
    TextStyle? yearTextStyle,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    Color? selectedYearTextColor,
    this.unselectedMonthsTextColor,
    Color? unselectedYearsTextColor,
    this.currentMonthTextColor,
    Color? currentYearTextColor,
    this.selectedDateRadius = 0,
    this.buttonBorder = const CircleBorder(),
  })  : unselectedYearsTextColor =
            unselectedYearsTextColor ?? unselectedMonthsTextColor,
        selectedYearTextColor = selectedYearTextColor ?? selectedMonthTextColor,
        currentYearTextColor = currentYearTextColor ?? currentMonthTextColor,
        yearTextStyle = yearTextStyle ?? monthTextStyle;

  /// The text style of all months on the page.
  ///
  /// default: `null`
  final TextStyle? monthTextStyle;

  /// The text color of the current month/year.
  ///
  /// default: `null`
  final Color? currentMonthTextColor;

  /// The text color of the current month/year.
  ///
  /// default: `currentMonthTextColor`
  final Color? currentYearTextColor;

  /// The current selected month/year background color.
  ///
  /// default: `null`
  final Color? selectedMonthBackgroundColor;

  /// The text color of the current selected month.
  ///
  /// default: `null`
  final Color? selectedMonthTextColor;

  /// The text color of the current selected year.
  ///
  /// default: `selectedMonthTextColor`
  final Color? selectedYearTextColor;

  /// The text color of the current unselected months.
  ///
  /// default: `null`
  final Color? unselectedMonthsTextColor;

  /// The text color of the current unselected years.
  ///
  /// default: `unselectedMonthsTextColor`
  final Color? unselectedYearsTextColor;

  /// The size of the current selected month/year circle.
  ///
  /// default: `0`
  final double selectedDateRadius;

  /// The text style of all years on the page.
  ///
  /// default: `monthTextStyle`
  final TextStyle? yearTextStyle;

  /// The border of the month/year buttons.
  ///
  /// default: `const CircleBorder()`
  final OutlinedBorder buttonBorder;

  PickerDateButtonsSettings copyWith({
    TextStyle? monthTextStyle,
    TextStyle? yearTextStyle,
    Color? selectedMonthBackgroundColor,
    Color? selectedMonthTextColor,
    Color? selectedYearTextColor,
    Color? unselectedMonthsTextColor,
    Color? unselectedYearsTextColor,
    Color? currentMonthTextColor,
    Color? currentYearTextColor,
    double? selectedDateRadius,
    OutlinedBorder? buttonBorder,
  }) {
    return PickerDateButtonsSettings(
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      yearTextStyle: yearTextStyle ?? this.yearTextStyle,
      selectedMonthBackgroundColor:
          selectedMonthBackgroundColor ?? this.selectedMonthBackgroundColor,
      selectedMonthTextColor:
          selectedMonthTextColor ?? this.selectedMonthTextColor,
      selectedYearTextColor:
          selectedYearTextColor ?? this.selectedYearTextColor,
      unselectedMonthsTextColor:
          unselectedMonthsTextColor ?? this.unselectedMonthsTextColor,
      unselectedYearsTextColor:
          unselectedYearsTextColor ?? this.unselectedYearsTextColor,
      currentMonthTextColor:
          currentMonthTextColor ?? this.currentMonthTextColor,
      currentYearTextColor: currentYearTextColor ?? this.currentYearTextColor,
      selectedDateRadius: selectedDateRadius ?? this.selectedDateRadius,
      buttonBorder: buttonBorder ?? this.buttonBorder,
    );
  }
}

///The default settings for the buttons style.
const defaultPickerDateButtonsSettings = PickerDateButtonsSettings();
