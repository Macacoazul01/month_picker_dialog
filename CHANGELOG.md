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
