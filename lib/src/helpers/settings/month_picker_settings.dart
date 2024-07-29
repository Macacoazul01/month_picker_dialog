import 'package:month_picker_dialog/month_picker_dialog.dart';

///Class to hold all the customizations of the date picker.
class MonthPickerDialogSettings {
  const MonthPickerDialogSettings({
    this.dialogSettings = defaultPickerdialogSettings,
    this.headerSettings = defaultPickerHeaderSettings,
    this.buttonsSettings = defaultPickerbuttonsSettings,
  });

  ///The customizations of the dialog part of the package.
  final PickerDialogSettings dialogSettings;

  ///The customizations of the header part of the package.
  final PickerHeaderSettings headerSettings;

  ///The customizations of the buttons part of the package.
  final PickerButtonsSettings buttonsSettings;
}

///The default settings for the month picker.
const defaultMonthPickerDialogSettings = MonthPickerDialogSettings();
