import 'package:flutter/material.dart';
import '/src/helpers/common.dart';

class yearUpDownPageProvider extends ChangeNotifier {
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

class monthUpDownPageProvider extends ChangeNotifier {
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
