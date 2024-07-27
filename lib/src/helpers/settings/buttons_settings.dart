import 'package:flutter/widgets.dart';

///Class to hold all the customizations of the buttons part of the package.
class PickerButtonsSettings {
  const PickerButtonsSettings({
    this.monthTextStyle,
    this.yearTextStyle,
    this.selectedMonthBackgroundColor,
    this.selectedMonthTextColor,
    this.unselectedMonthsTextColor,
    this.currentMonthTextColor,
    this.selectedDatePadding = 0,
    this.buttonBorder = const CircleBorder(),
  });

  /// The text style of all months on the page.
  ///
  /// default: `null`
  final TextStyle? monthTextStyle;

  /// The text color of the current month/year.
  ///
  /// default: `null`
  final Color? currentMonthTextColor;

  /// The current selected month/year background color.
  ///
  /// default: `null`
  final Color? selectedMonthBackgroundColor;

  /// The text color of the current selected month/year.
  ///
  /// default: `null`
  final Color? selectedMonthTextColor;

  /// The text color of the current unselected months/years.
  ///
  /// default: `null`
  final Color? unselectedMonthsTextColor;

  /// The size of the current selected month/year circle.
  ///
  /// default: `0`
  final double selectedDatePadding;

  /// The text style of all years on the page.
  ///
  /// default: `null`
  final TextStyle? yearTextStyle;

  /// The border of the month/year buttons.
  ///
  /// default: `const CircleBorder()`
  final OutlinedBorder buttonBorder;
}

///The default settings for the buttons style.
const defaultPickerbuttonsSettings = PickerButtonsSettings();
