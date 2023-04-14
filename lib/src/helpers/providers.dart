import 'package:flutter/material.dart';
import '/src/helpers/common.dart';

///Provider that controlls the up down state of the header when the year selector is on the dialog
class YearUpDownPageProvider extends ChangeNotifier {
  final UpDownPageLimit _pageLimit = UpDownPageLimit(0, 0);
  final UpDownButtonEnableState _enableState =
      UpDownButtonEnableState(true, true);

  UpDownPageLimit get pageLimit => _pageLimit;
  UpDownButtonEnableState get enableState => _enableState;

  void changePage(int downLimit, int upLimit, bool? downState, bool? upState) {
    _pageLimit
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
  final UpDownPageLimit _pageLimit = UpDownPageLimit(0, 0);
  final UpDownButtonEnableState _enableState =
      UpDownButtonEnableState(true, true);

  UpDownPageLimit get pageLimit => _pageLimit;
  UpDownButtonEnableState get enableState => _enableState;

  void changePage(int downLimit, int upLimit, bool? downState, bool? upState) {
    _pageLimit
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
