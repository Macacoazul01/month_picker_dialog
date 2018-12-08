import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Displays month picker dialog.
Future<DateTime> showMonthPicker({
  @required BuildContext context,
  @required DateTime initialDate,
}) async {
  assert(context != null);
  assert(initialDate != null);
  return await showDialog<DateTime>(
    context: context,
    builder: (context) => _MonthPickerDialog(initialDate: initialDate),
  );
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const _MonthPickerDialog({Key key, this.initialDate}) : super(key: key);

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  PageController pageController;
  DateTime selectedDate;
  int displayedYear;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);
    displayedYear = selectedDate.year;
    pageController = PageController(initialPage: displayedYear);
  }

  String _locale(BuildContext context) {
    var locale = Localizations.localeOf(context);
    if (locale == null) {
      return Intl.systemLocale;
    }
    return '${locale.languageCode}_${locale.countryCode}';
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var localizations = MaterialLocalizations.of(context);
    var locale = _locale(context);
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Material(
            color: theme.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${DateFormat.yMMMM(locale).format(selectedDate)}',
                    style: theme.primaryTextTheme.subhead,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${DateFormat.y(locale).format(DateTime(displayedYear))}',
                          style: theme.primaryTextTheme.headline,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: theme.primaryIconTheme.color,
                        ),
                        onPressed: () => pageController.animateToPage(
                            displayedYear - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: theme.primaryIconTheme.color,
                        ),
                        onPressed: () => pageController.animateToPage(
                            displayedYear + 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 250.0,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  displayedYear = index;
                });
              },
              itemBuilder: (context, year) {
                return GridView.count(
                    padding: EdgeInsets.all(8.0),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: List<int>.generate(12, (i) => i + 1)
                        .map((month) => DateTime(year, month))
                        .map(
                          (date) => Padding(
                                padding: EdgeInsets.all(4.0),
                                child: FlatButton(
                                  onPressed: () => setState(() {
                                        selectedDate =
                                            DateTime(date.year, date.month);
                                      }),
                                  shape: CircleBorder(),
                                  color: date.month == selectedDate.month &&
                                          date.year == selectedDate.year
                                      ? theme.accentColor
                                      : null,
                                  textColor: date.month == selectedDate.month &&
                                          date.year == selectedDate.year
                                      ? theme.accentTextTheme.button.color
                                      : date.month == DateTime.now().month &&
                                              date.year == DateTime.now().year
                                          ? theme.accentColor
                                          : null,
                                  child: Text(
                                    DateFormat.MMM(locale).format(date),
                                  ),
                                ),
                              ),
                        )
                        .toList());
              },
            ),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text(localizations.cancelButtonLabel),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context, selectedDate),
                  child: Text(localizations.okButtonLabel),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
