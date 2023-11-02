import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:month_picker_dialog/src/helpers/controller.dart';
import 'package:month_picker_dialog/src/helpers/extensions.dart';

void main() {
  test('default_controller_test', () {
    final MonthpickerController controller = MonthpickerController(
      capitalizeFirstLetter: false,
      yearFirst: true,
      roundedCornersRadius: 0,
      forceSelectedDate: false,
      animationMilliseconds: 300,
      hideHeaderRow: false,
      theme: ThemeData.fallback(),
      useMaterial3: false,
      selectedMonthPadding: 0,
    );
    controller.initialize();
    expect(controller.yearItemCount, 9999);
    expect(controller.yearPageCount, 834);
    expect(controller.monthPageCount, 9999);
    expect(controller.selectedDate, DateTime.now().firstDayOfMonth());
    expect(controller.localFirstDate, null);
    expect(controller.localLastDate, null);
    expect(controller.customHeight, null);
    expect(controller.customWidth, null);
    controller.firstPossibleMonth(2120);
    expect(controller.selectedDate, DateTime(2120));
  });

  test('controller_with_parameters_test', () {
    final MonthpickerController controller = MonthpickerController(
      capitalizeFirstLetter: false,
      yearFirst: true,
      roundedCornersRadius: 0,
      firstDate: DateTime(2022, 1, 15),
      lastDate: DateTime(2027, 1, 15),
      initialDate: DateTime(2023),
      forceSelectedDate: false,
      selectableMonthPredicate: (DateTime val) => val.month.isEven,
      animationMilliseconds: 300,
      hideHeaderRow: false,
      customHeight: 250,
      customWidth: 310,
      theme: ThemeData.fallback(),
      useMaterial3: false,
      selectedMonthPadding: 1,
    );
    controller.initialize();
    expect(controller.yearItemCount, 6);
    expect(controller.yearPageCount, 1);
    expect(controller.monthPageCount, 6);
    expect(controller.customHeight, 250);
    expect(controller.customWidth, 310);
    expect(controller.selectedDate, DateTime(2023));
    expect(controller.localFirstDate, DateTime(2022));
    expect(controller.localLastDate, DateTime(2027));
    controller.firstPossibleMonth(2120);
    expect(controller.selectedDate, DateTime(2120, 2));
    expect(controller.selectedMonthPadding, 1);
  });
}
