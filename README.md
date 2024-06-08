# month_picker_dialog
![Build Status](https://img.shields.io/github/actions/workflow/status/hmkrivoj/month_picker_dialog/dart.yml)
[![pub package](https://img.shields.io/pub/v/month_picker_dialog.svg)](https://pub.dev/packages/month_picker_dialog)

Internationalized material style dialog for picking a single month from an infinite list of years.
This package makes use of the intl package and flutter's i18n abilities to provide labels in all languages known to flutter.


[Setting up an internationalized app: the flutter localization package](https://flutter.io/docs/development/accessibility-and-localization/internationalization#setting-up-an-internationalized-app-the-flutter_localizations-package)

![LTR portrait](screenshots/ltr_portrait.png)

## How to use it:

Just add `showMonthPicker()` or use `showMonthRangePicker()` to select by range inside your button function like a normal date picker dialog (context parameter is required):

since 0.6.0 initialDate isn't required anymore!

### Example:

```dart
FloatingActionButton(
    onPressed: () {
        showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        ).then((date) {
        if (date != null) {
            setState(() {
            selectedDate = date;
            });
        }
        });
    },
    child: Icon(Icons.calendar_today),
),

FloatingActionButton(
    onPressed: () {
        showMonthRangePicker(
        context: context,
        initialDate: DateTime.now(),
        rangeList: true,
        ).then((List<DateTime>? dates) {
        if (dates != null) {
            print(dates);
            print(dates.last.lastDayOfMonth());
        }
        });
    },
    child: Icon(Icons.calendar_today),
),

```

## Landscape:
![LTR landscape](screenshots/ltr_landscape.png)

## Parameters list:

There are other parameters to configure on the dialog if you want to do so:

`initialDate` is the initially selected month.

`firstDate` is the optional lower bound for month selection.

`lastDate` is the optional upper bound for month selection.

`selectableMonthPredicate` lets you control enabled months just like the official selectableDayPredicate.

`monthStylePredicate` and `yearStylePredicate` properties allow passing a different style for each month or year.

`capitalizeFirstLetter` lets you control if your months names are capitalized or not.

`headerColor` lets you control the calendar header color.

`headerTextColor` lets you control the calendar header text and arrows color.

`selectedMonthBackgroundColor` lets you control the current selected month/year background color.

`selectedMonthTextColor` lets you control the text color of the current selected month/year.

`unselectedMonthTextColor` lets you control the text color of the current unselected months/years.

`currentMonthTextColor` lets you control the text color of the current month/year.

`selectedMonthPadding` lets you control the size of the current selected month/year circle by increasing the padding of it.

`backgroundColor` lets you control if the dialog will have a custom background color.

`confirmWidget` lets you set a custom confirm widget.

`cancelWidget` lets you set a custom cancel widget.

`customHeight` lets you set a custom height for the calendar widget (default is 240).

`customWidth` lets you set a custom width for the calendar widget (default is 320).

`yearFirst` lets you define that the user must select first the year, then the month.

`dismissible` lets you define if the dialog will be dismissible by clicking outside it.

`roundedCornersRadius` lets you define the Radius of the rounded dialog (default is 0).

`animationMilliseconds` lets you define the speed of the page transition animation (default is 450).

`hideHeaderRow` lets you hide the row with the arrows + years/months page range from the header, forcing the user to scroll to change the page (default is false).

`textScaleFactor` lets you control the scale of the texts in the widget.

`arrowSize` lets you control the size of the header arrows.

`forcePortrait` lets you block the widget from entering in landscape mode.

`customDivider` lets you add a custom divider between the months/years and the confirm/cancel buttons.

`dialogBorderSide:` lets you define the border side of the dialog (default is `BorderSide.none`).

`blockScrolling:` lets you block the user from scrolling the months/years (default is `true`).

`buttonBorder:` lets you define the border of the month/year buttons (default is `const CircleBorder()`).

`headerTitle:` lets you add a custom title to the header of the dialog (default is `null`).

### Range Picker only:

`rangeList:` lets you define if the controller will return the full list of months between the two selected or only them (default is `false`).


## Contributors:
[Gian Bettega](https://github.com/Macacoazul01)

[Dimitri Krivoj](https://github.com/hmkrivoj) (the original creator of the package)

[Fabio Henrique](https://github.com/FabioClem)

[Leon Colt](https://github.com/LeonColt)

[Wesley Gonzaga](https://github.com/wesleygonalv)

[Efrain Bastidas](https://github.com/Wolfteam)

[Volodymyr Hyrka](https://github.com/Vov4yk)

[Bern](https://github.com/Berneyw)

[just1982](https://github.com/just1982)

[Sagar Zala](https://github.com/sagarzala123)

[Pong Loong Yeat](https://github.com/pongloongyeat)

[Masayuki Ono](https://github.com/mono0926)

[Alecsplus](https://github.com/Alecsplus)

[Lautaro Zanuttini](https://github.com/lautarozanuttini)