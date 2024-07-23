import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void main() {
  test('default_controller_test', () {
    final MonthpickerController controller = MonthpickerController(
      previousIcon: Icons.keyboard_arrow_up,
      nextIcon: Icons.keyboard_arrow_down,
      monthTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      selectedMonthTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      yearTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      hideHeaderRow: false,
      theme: ThemeData.fallback(),
      useMaterial3: false,
      selectedMonthPadding: 0,
      buttonBorder: const CircleBorder(),
      headerTitle: null,
      rangeMode: false,
      rangeList: false, 
      monthPickerDialogSettings: defaultMonthPickerDialogSettings,
    );
    controller.initialize();
    expect(controller.yearItemCount, 9999);
    expect(controller.yearPageCount, 834);
    expect(controller.monthPageCount, 9999);
    expect(controller.selectedDate, controller.now);
    expect(controller.localFirstDate, null);
    expect(controller.localLastDate, null);
    expect(controller.monthPickerDialogSettings.pickerDialogSettings.customHeight, 240);
    expect(controller.monthPickerDialogSettings.pickerDialogSettings.customWidth, 320);
    controller.firstPossibleMonth(2120);
    expect(controller.selectedDate, DateTime(2120));
    expect(controller.rangeMode, false);
  });

  test('controller_with_parameters_test', () {
    final MonthpickerController controller = MonthpickerController(
      previousIcon: Icons.keyboard_arrow_up,
      nextIcon: Icons.keyboard_arrow_down,
      monthTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      selectedMonthTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      yearTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      firstDate: DateTime(2022, 1, 15),
      lastDate: DateTime(2027, 1, 15),
      initialDate: DateTime(2023),
      selectableMonthPredicate: (DateTime val) => val.month.isEven,
      hideHeaderRow: false,
      theme: ThemeData.fallback(),
      useMaterial3: false,
      selectedMonthPadding: 1,
      buttonBorder: const CircleBorder(),
      headerTitle: null,
      rangeMode: true,
      rangeList: true,
      monthPickerDialogSettings: MonthPickerDialogSettings(
        pickerDialogSettings: PickerDialogSettings(
          customHeight: 250,
          customWidth: 310,
          forcePortrait: true
        )
      ),
    );
    controller.initialize();
    expect(controller.yearItemCount, 6);
    expect(controller.yearPageCount, 1);
    expect(controller.monthPageCount, 6);
    expect(controller.monthPickerDialogSettings.pickerDialogSettings.customHeight, 250);
    expect(controller.monthPickerDialogSettings.pickerDialogSettings.customWidth, 310);
    expect(controller.selectedDate, DateTime(2023));
    expect(controller.localFirstDate, DateTime(2022));
    expect(controller.localLastDate, DateTime(2027));
    controller.firstPossibleMonth(2120);
    expect(controller.selectedDate, DateTime(2120, 2));
    expect(controller.selectedMonthPadding, 1);
    expect(controller.monthPickerDialogSettings.pickerDialogSettings.forcePortrait, true);
    expect(controller.rangeMode, true);
  });
}
