import 'package:flutter/widgets.dart';

///Class to hold all the customizations of the action bar part of the package.
class PickerActionBarSettings {
  const PickerActionBarSettings({
    this.buttonSpacing = 0,
    this.confirmWidget,
    this.cancelWidget,
    this.customDivider,
  });

  /// The size of the current selected month/year circle.
  ///
  /// default: `0`
  final double buttonSpacing;

  ///The custom confirm widget of the dialog.
  ///
  /// default: `null`
  final Widget? confirmWidget;

  ///The custom cancel widget of the dialog.
  ///
  /// default: `null`
  final Widget? cancelWidget;

  ///The custom divider between the months/years and the confirm/cancel buttons.
  ///
  /// default: `null`
  final Widget? customDivider;
}

///The default settings for the buttons style.
const defaultPickerActionBarSettings = PickerActionBarSettings();