import 'package:flutter/widgets.dart';

///Class to hold all the customizations of the dialog part of the package.
class PickerDialogSettings {
  const PickerDialogSettings({
    this.scrollAnimationMilliseconds = 450,
    this.textScaleFactor,
    this.customHeight = 240,
    this.customWidth = 320,
    this.dialogRoundedCornersRadius = 0,
    this.yearFirst = false,
    this.dismissible = false,
    this.forcePortrait = false,
    this.blockScrolling = true,
    this.forceSelectedDate = false,
    this.capitalizeFirstLetter = true,
    this.dialogBorderSide = BorderSide.none,
    this.dialogBackgroundColor,
    this.locale,
    this.insetPadding,
  }) : assert(forceSelectedDate == dismissible || !forceSelectedDate,
            'forceSelectedDate can only be used with dismissible = true');

  /// The speed of the calendar page transition animation.
  ///
  /// default: `450`
  final int scrollAnimationMilliseconds;

  /// The scale of the texts in the widget.
  ///
  /// default: `null`
  final double? textScaleFactor;

  /// The height of the calendar widget.
  ///
  /// default: `240`
  final double customHeight;

  /// The width of the calendar widget.
  ///
  /// default: `320`
  final double customWidth;

  /// The Radius of the dialog.
  ///
  /// default: `0`
  final double dialogRoundedCornersRadius;

  /// Forces the user to select first the year, then the month.
  ///
  /// default: `false`
  final bool yearFirst;

  /// If the dialog will be dismissible by clicking outside it.
  ///
  /// default: `false`
  final bool dismissible;

  /// Blocks the widget from entering in landscape mode.
  ///
  /// default: `false`
  final bool forcePortrait;

  /// Blocks the user from scrolling the month/year pages.
  ///
  /// default: `true`
  final bool blockScrolling;

  /// Defines that the current selected date will be returned if the user clicks outside of the dialog. Needs `dismissible = true`.
  ///
  /// default: `false`
  final bool forceSelectedDate;

  /// if the months names are capitalized or not.
  ///
  /// default: `true`
  final bool capitalizeFirstLetter;

  /// Defines the border side of the dialog.
  ///
  /// default: `BorderSide.none`
  final BorderSide dialogBorderSide;

  /// Defines the background color of the calendar on the dialog.
  ///
  /// default: `null`
  final Color? dialogBackgroundColor;

  /// Defines the locale of the dialog.
  ///
  /// default: `null`
  final Locale? locale;

  /// Defines the insetPadding of the dialog.
  ///
  /// default: `null`
  final EdgeInsets? insetPadding;
}

///The default settings for the Dialog style.
const defaultPickerdialogSettings = PickerDialogSettings();
