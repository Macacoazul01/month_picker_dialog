import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

final UpDownPageLimit _yearUpDownPageLimit = UpDownPageLimit(0, 0);
final UpDownPageLimit _monthUpDownPageLimit = UpDownPageLimit(0, 0);

///Provider that controlls the up down state of the header when the year selector is on the dialog
class YearUpDownPageProvider extends ChangeNotifier {
  final UpDownButtonEnableState _enableState =
      UpDownButtonEnableState(true, true);

  UpDownPageLimit get pageLimit => _yearUpDownPageLimit;
  UpDownButtonEnableState get enableState => _enableState;

  void changePage(int downLimit, int upLimit, bool? downState, bool? upState) {
    _yearUpDownPageLimit
      ..downLimit = downLimit
      ..upLimit = upLimit;

    if (downState != null && upState != null) {
      _enableState
        ..downState = downState
        ..upState = upState;
    }

    notifyListeners();
  }
}

///Provider that controlls the up down state of the header when the monyh selector is on the dialog
class MonthUpDownPageProvider extends ChangeNotifier {
  final UpDownButtonEnableState _enableState =
      UpDownButtonEnableState(true, true);

  UpDownPageLimit get pageLimit => _monthUpDownPageLimit;
  UpDownButtonEnableState get enableState => _enableState;

  void changePage(int downLimit, int upLimit, bool? downState, bool? upState) {
    _monthUpDownPageLimit
      ..downLimit = downLimit
      ..upLimit = upLimit;

    if (downState != null && upState != null) {
      _enableState
        ..downState = downState
        ..upState = upState;
    }

    notifyListeners();
  }
}
