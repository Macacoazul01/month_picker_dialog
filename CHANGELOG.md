## 6.3.0 - 2025-07-04
- Added `onYearSelected` and `onMonthSelected` functions to provide a callback after the user selects a value.

## 6.2.5 - 2025-07-04
- Added copyWith Method to picker settings. Tks [nomoruyi](https://github.com/nomoruyi).

## 6.2.4 - 2025-06-30
- Small changes to HeaderRow to make more clear to the user that the year is a button.

## 6.2.3 - 2025-05-30
- Added headerAlignment parameter to `PickerHeaderSettings`.

## 6.2.2 - 2025-05-23
- Added arrowAlpha parameter to `PickerHeaderSettings`.
- Fixed sample. 

## 6.2.1 - 2025-05-19
- Fixes [#116](https://github.com/Macacoazul01/month_picker_dialog/issues/116).Tks [sheldontuitt](https://github.com/sheldontuitt).
- Fixes a bug introduced in 6.2.0.
- Updated android sample.

## 6.2.0 - 2025-05-19
- Bumped intl to `0.20.0`.
- Added `PickerActionBarSettings.actionBarPadding` to handle the Padding of the ActionBar.

## 6.0.3 - 2025-01-02
- Downgraded intl to 0.19.0 until `flutter_localizations` starts to use 0.20+. Please use the dev version of this package if you need latest intl.[#112](https://github.com/Macacoazul01/month_picker_dialog/issues/112).

## 6.0.2 - 2024-12-16
- Fixed [#109](https://github.com/Macacoazul01/month_picker_dialog/issues/109).
- Improved function docs.

## 6.0.1 - 2024-12-16
- Improved sample

## 6.0.0 - 2024-12-14
- Added `PickerActionBarSettings` to handle the action bar settings of the dialog.
- [Breaking] `confirmWidget`, `cancelWidget`, `customDivider` are now on the `PickerActionBarSettings` class.
- [Breaking] renamed `PickerButtonsSettings` to `PickerDateButtonsSettings` and `buttonsSettings` to `dateButtonsSettings`.

## 5.2.0 - 2024-12-14
- Bumped intl to `0.20.0`. Fixes [#107](https://github.com/Macacoazul01/month_picker_dialog/issues/107).
- Bumped flutter_lints to `5.0.0`.
- Fixed flutter `3.27.0` deprecations.

## 5.1.3 - 2024-09-07
- Fixed [#106](https://github.com/Macacoazul01/month_picker_dialog/issues/106).
- Updated android sample.

## 5.1.2 - 2024-08-20
- Fixed [#104](https://github.com/Macacoazul01/month_picker_dialog/issues/104).

## 5.1.1 - 2024-08-19
- Fixed [#105](https://github.com/Macacoazul01/month_picker_dialog/issues/105).

## 5.1.0 - 2024-08-17
- removed `initialDate` parameter from `showMonthRangePicker`.
- added `initialRangeDate` parameter to `showMonthRangePicker`. Fixes [#103](https://github.com/Macacoazul01/month_picker_dialog/issues/103)
- added `endRangeDate` parameter to `showMonthRangePicker`. Fixes [#103](https://github.com/Macacoazul01/month_picker_dialog/issues/103)
- made `firstDayOfMonth` and `lastDayOfMonth` extensions nullable.

## 5.0.0 - 2024-08-02
- [Breaking] Reworked dialog configuration to use the new class `MonthPickerDialogSettings`. Please follow the sample app to learn how to configure your widget using the new way (or feel free to open an issue on github).
- Added new ways to customize the header, months/years pages and the dialog behavior with different parameters for the year and month selectors.
- Added `showYearPicker` function to the package. Now its possible to return only a year.
- Added `selectableYearPredicate` to range and single month pickers. It lets you control enabled years like `selectableMonthPredicate`.
- Updated sample and readme.

## 4.0.1 - 2024-07-05
- Improved locale selection. [#98](https://github.com/Macacoazul01/month_picker_dialog/pull/98)

## 4.0.0 - 2024-06-07
- Added `showMonthRangePicker` function to the package. Now its possible to return a range of months too. Tks [Lautaro Zanuttini](https://github.com/lautarozanuttini)
- Updated web sample.
- Added `lastDayOfMonth` DateTime extension. if you want to get the last day of the month from one of your selected dates.
- Updated sample and readme.

## 3.0.0 - 2024-05-13
- Bumped intl to `0.19.0`.
- Bumped flutter_lints to `4.0.0`.

## 2.12.0 - 2024-05-13
- Added `buttonBorder:` property to allow you define the border of the month/year buttons (default is `const CircleBorder()`) [#92](https://github.com/Macacoazul01/month_picker_dialog/pull/92).
- Added `headerTitle:` property to allow you add a custom title to the header of the dialog (default is `null`) [#92](https://github.com/Macacoazul01/month_picker_dialog/pull/92).

## 2.11.2 - 2024-04-02
- Removed unnecessary dependencies.

## 2.11.1 - 2024-03-12
- Bumped provider to `6.1.2`.
- Improved some docs.

## 2.11.0 - 2024-02-20
- Fixed [#87](https://github.com/Macacoazul01/month_picker_dialog/issues/87).

## 2.10.0 - 2024-02-19
- Added `dialogBorderSide:` property to allow you define the border side of the dialog (default is `BorderSide.none`).
- Added `blockScrolling:` property to allow you block the user from scrolling the months/years (default is `true`).
- Wraped portrait dialog in a SingleChildScrollView to avoid overflow [#85](https://github.com/Macacoazul01/month_picker_dialog/issues/85).

## 2.8.0 - 2024-02-19
- Added `currentMonthTextColor` property to allow you control the text color of the current month/year.

## 2.7.0 - 2024-02-13
- Exposed `MonthPickerDialog` widget.
- Improved files organization.

## 2.6.0 - 2024-01-17
- Added `customDivider` property to allow you add a custom divider between the months/years and the confirm/cancel buttons.

## 2.5.1 - 2024-01-17
- Mini fix in `customWidth`.

## 2.5.0 - 2024-01-17
- Added `forcePortrait` property to allow you block the widget from entering in landscape mode.

## 2.4.0 - 2023-12-08
- Added `arrowSize` property to allow you control the size of the header arrows.

## 2.3.0 - 2023-12-08
- Removed deprecated `textScaleFactor` inside the package (the name of the parameter stays the same)
- Bumped dart to `3.0.0`,provider to `6.1.1`, intl to `0.18.1` and flutter_lints to `3.0.1`

## 2.2.1 - 2023-11-03
- Added `textScaleFactor` property to allow controlling the scale of the texts in the widget [77](https://github.com/hmkrivoj/month_picker_dialog/pull/77).
- Wrap portrait mode dialog in IntrinsicWidth to prevent oversized content [76](https://github.com/hmkrivoj/month_picker_dialog/pull/76).

## 2.1.0 - 2023-11-01
- Added `selectedMonthPadding` property to allow you control the size of the current selected month/year circle by increasing the padding of it (default is 0) [74](https://github.com/hmkrivoj/month_picker_dialog/issues/74).
- Added web to sample.

## 2.0.2
- Moved theme to the controller
- Added default locale strings to the action buttons [73](https://github.com/hmkrivoj/month_picker_dialog/pull/73).

## 2.0.0
- Breaking: bumped to dart 3 + intl 0.18.0 (latest one on flutter_localizations)

## 1.3.0
- Added `hideHeaderRow` property to allow you hide the row with the arrows + years/months page range from the header, forcing the user to scroll to change the page (default is false).

## 1.2.2
- Added `animationMilliseconds` property to allow you define the speed of the page transition animation (default is 450).
- Removed unnecessary column.
- Changed default `customHeight` to 240.

## 1.2.0
- Added `monthStylePredicate` and `yearStylePredicate` properties to allow passing a different style for each month or year [67](https://github.com/hmkrivoj/month_picker_dialog/pull/67).
- Added documentation on some of the code
- Fixed provider names to pass static analysis

## 1.1.0
- Added `backgroundColor` property to allow the dialog to have a different background of the default from the theme.

## 1.0.0
- Removed `RxDart` from the code in favor of [Provider](https://pub.dev/packages/provider).
- Fixed an old error where the year/month becomes zero when changing the orientation [30](https://github.com/hmkrivoj/month_picker_dialog/issues/30).

## 0.8.1
- Another fix on header arrow [61](https://github.com/hmkrivoj/month_picker_dialog/issues/61).

## 0.8.0
- Mini fix on header arrow. Bumped to 0.8 because of the braking change on `0.7.1` 

## 0.7.1
- Breaking: `confirmText` and `cancelText` were replaced by `confirmWidget` and `cancelWidget`. Now it's possible to use any widget instead of only `Text()` in the buttons

## 0.7.0
- Added `forceSelectedDate` to fix [41](https://github.com/hmkrivoj/month_picker_dialog/issues/41).The parameter lets you define that the current selected date will be returned if the user clicks outside of the dialog. Needs `dismissible = true`

## 0.6.3
- code cleanup in preparation to fix [41](https://github.com/hmkrivoj/month_picker_dialog/issues/41) and [30](https://github.com/hmkrivoj/month_picker_dialog/issues/30) in the next major version

## 0.6.2
- updated to flutter 2.19.2 and fixed deprecations

## 0.6.1+2
- readme fix

## 0.6.1
- border now changes with orientation

## 0.6.0
- `initialDate` isn't required anymore!

## 0.5.8
- added `roundedCornersRadius` -> lets you define the Radius of the rounded dialog (tks [Fabio Henrique](https://github.com/FabioClem)).

- bump rxdart to 0.27.7

## 0.5.6
- removed deprecated parameter from TextButton.styleFrom
- improved readme

- added `dismissible` parameter -> lets you define if the dialog will be dismissible by clicking outside it (false as default).

## 0.5.5
- bump rxdart to ^0.27.5
- removed MaterialLocalizations from code. First part of the changes to let people use designs different than Material

## 0.5.4 + 1 
- month selector cleanup/organization + more small fixes

## 0.5.4
- code cleanup/organization (with some possible small performance improvement)

## 0.5.3
- added `customHeight` -> lets you set a custom height for the calendar widget.

- added `customWidth` -> lets you set a custom width for the calendar widget.

- added `yearFirst` -> lets you define that the user must select first the year, then the month (false as default).

## 0.5.0
- added `headerColor` -> lets you control the calendar header color.

- added `headerTextColor` -> lets you control the calendar header text and arrows color.

- added `selectedMonthBackgroundColor` -> lets you control the current selected month/year background color.

- added `selectedMonthTextColor` -> lets you control the text color of the current selected month/year.

- added `unselectedMonthTextColor` -> lets you control the text color of the current unselected months/years.

- added `confirmText` -> lets you set a custom confirm text widget.

- added `cancelText` -> lets you set a custom cancel text widget.

- updated sample with the new parameters

## 0.4.7
- fixes on `selectableMonthPredicate` parameter + sample

## 0.4.6 + 2
- size fixes

## 0.4.6 + 1
- made the month selector barrier dismissible parameter = false

## 0.4.6
- added `capitalizeFirstLetter` -> Enable you to choose if the first letter of the month will be capitalized thks https://github.com/0wzZZzz6

## 0.4.5
- added `selectableMonthPredicate` -> Enable selective months disabling thks https://github.com/ahmdaeyz

## 0.4.1+1
- package rename

## 0.4.1
- partial update to flutter 3

## 0.4.0
- support for flutter 2 null safety (thanks @quantosapplications)

## 0.3.3
- pagebounds bug with `firstDate == null` fixed (thanks @mono0926)
- deprecation warnings for text themes fixed
## 0.3.2
- you can now provide custom localizations
- bump up rxdart dependency

## 0.3.1
- migrated example app to androidx
- fixed deprecation warning for buttonthemebar
- fixed dependency issue

## 0.3.0
- architectural changes (using `rxdart` now)
- fixed bug where header and pageview could scroll to 0 and infinity despite `firstDate` and `lastDate` being set
- added animation for transition between year selection mode and month selection mode

## 0.2.3
- intl dependency is now `>=0.1.0<2.0.0` to appease the maintenance analysis on pub.dev

## 0.2.2
- Reverting to 0.2.0 because of dependency issues

## 0.2.1
- Upgraded dependency: `intl: ^0.16.0` 

## 0.2.0
- Show list of years by tapping year label
- Dart 2.2.2 is now required

## 0.1.1
- Bound month selection

## 0.0.8
- Refactoring and removal of white border 

## 0.0.6
- Renamed docs to screenshots to appease to pub

## 0.0.5
- Provided screenshots to README
