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
    this.yearsPerPage = 12,
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

  /// Defines how many years will be shown on each page.
  ///
  /// default: `12`
  final int yearsPerPage;

  PickerDialogSettings copyWith({
    int? scrollAnimationMilliseconds,
    double? textScaleFactor,
    double? customHeight,
    double? customWidth,
    double? dialogRoundedCornersRadius,
    bool? yearFirst,
    bool? dismissible,
    bool? forcePortrait,
    bool? blockScrolling,
    bool? forceSelectedDate,
    bool? capitalizeFirstLetter,
    BorderSide? dialogBorderSide,
    Color? dialogBackgroundColor,
    Locale? locale,
    EdgeInsets? insetPadding,
    int? yearsPerPage,
  }) {
    return PickerDialogSettings(
      scrollAnimationMilliseconds:
          scrollAnimationMilliseconds ?? this.scrollAnimationMilliseconds,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      customHeight: customHeight ?? this.customHeight,
      customWidth: customWidth ?? this.customWidth,
      dialogRoundedCornersRadius:
          dialogRoundedCornersRadius ?? this.dialogRoundedCornersRadius,
      yearFirst: yearFirst ?? this.yearFirst,
      dismissible: dismissible ?? this.dismissible,
      forcePortrait: forcePortrait ?? this.forcePortrait,
      blockScrolling: blockScrolling ?? this.blockScrolling,
      forceSelectedDate: forceSelectedDate ?? this.forceSelectedDate,
      capitalizeFirstLetter:
          capitalizeFirstLetter ?? this.capitalizeFirstLetter,
      dialogBorderSide: dialogBorderSide ?? this.dialogBorderSide,
      dialogBackgroundColor:
          dialogBackgroundColor ?? this.dialogBackgroundColor,
      locale: locale ?? this.locale,
      insetPadding: insetPadding ?? this.insetPadding,
      yearsPerPage: yearsPerPage ?? this.yearsPerPage,
    );
  }
}

///The default settings for the Dialog style.
const defaultPickerDialogSettings = PickerDialogSettings();
