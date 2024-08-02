import 'package:flutter/material.dart';

///Class to hold all the customizations of the dialog part of the package.
class PickerHeaderSettings {
  const PickerHeaderSettings({
    this.hideHeaderRow = false,
    this.previousIcon = Icons.keyboard_arrow_up,
    this.nextIcon = Icons.keyboard_arrow_down,
    this.headerIconsSize,
    this.headerIconsColor,
    this.headerBackgroundColor,
    this.headerSelectedIntervalTextStyle,
    this.headerCurrentPageTextStyle,
    this.titleSpacing = 5,
  });

  /// Hides the row with the arrows + years/months page range from the header, forcing the user to scroll to change the page.
  ///
  /// default: `false`
  final bool hideHeaderRow;

  /// The icon that will make the calendar to go back one page when clicked.
  ///
  /// default: `Icons.keyboard_arrow_up`
  final IconData previousIcon;

  /// The icon that will make the calendar to go to the next page when clicked.
  ///
  /// default: `Icons.keyboard_arrow_up`
  final IconData nextIcon;

  /// The Size of the header Icons.
  ///
  /// default: `null`
  final double? headerIconsSize;

  /// The text color of the header Icons. If null it will follow the header text color.
  ///
  /// default: `null`
  final Color? headerIconsColor;

  /// The color of the header's background.
  ///
  /// default: `null`
  final Color? headerBackgroundColor;

  /// The text style of the current selected month/year/range.
  ///
  /// default: `null`
  final TextStyle? headerSelectedIntervalTextStyle;

  /// The text style of current page title on the header.
  ///
  /// default: `null`
  final TextStyle? headerCurrentPageTextStyle;

  /// The space between the title widget and the current selected month/year/range text on the header.
  ///
  /// It will only appear if headerTitle widget isn't null.
  ///
  /// default: `5`
  final double titleSpacing;
}

///The default settings for the Header style.
const defaultPickerHeaderSettings = PickerHeaderSettings();
