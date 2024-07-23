import '/month_picker_dialog.dart';

///Class to hold all the customizations of the date picker.
class MonthPickerDialogSettings {
  const MonthPickerDialogSettings({
    this.pickerDialogSettings = defaultPickerDialogSettings,  
  });

  ///The customizations of the dialog part of the package.
   final PickerDialogSettings pickerDialogSettings;
}

///The default settings for the month picker.
const defaultMonthPickerDialogSettings = MonthPickerDialogSettings();