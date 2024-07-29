import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void main() => runApp(
      MaterialApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('zh'),
          Locale('fr'),
          Locale('es'),
          Locale('de'),
          Locale('ru'),
          Locale('ja'),
          Locale('ar'),
          Locale('fa'),
          Locale('es'),
          Locale('it'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.pinkAccent),
          //Changing the global dialog border
          dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        home: MyApp(
          initialDate: DateTime.now(),
        ),
      ),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialDate});
  final DateTime initialDate;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Month Picker Example App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    await showMonthPicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 5, 5),
                      lastDate: DateTime(DateTime.now().year + 8, 9),
                      initialDate: selectedDate ?? widget.initialDate,
                      selectableMonthPredicate: (DateTime val) =>
                          val.month.isEven,
                      selectableYearPredicate: (int year) => year.isEven,
                      monthStylePredicate: (DateTime val) {
                        if (val.month == 4) {
                          return TextButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            textStyle: const TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return null;
                      },
                      yearStylePredicate: (int val) {
                        if (val == 2022) {
                          return TextButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            textStyle: const TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return null;
                      },
                      confirmWidget: Text(
                        'This one!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[300],
                        ),
                      ),
                      cancelWidget: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                    ).then((DateTime? date) {
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    });
                  },
                  child: const Text('Single month picker'),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) => FloatingActionButton(
          onPressed: () {
            showMonthRangePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 5, 5),
              lastDate: DateTime(DateTime.now().year + 8, 9),
              initialDate: selectedDate ?? widget.initialDate,
              confirmWidget: Text(
                'This one!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[300],
                ),
              ),
              cancelWidget: Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              headerTitle: const Text('Month Picker Dialog'),
              monthPickerDialogSettings: MonthPickerDialogSettings(
                dialogSettings: PickerDialogSettings(
                  locale: const Locale('en'),
                  dialogRoundedCornersRadius: 20,
                  dialogBackgroundColor: Colors.blueGrey[50],
                ),
                headerSettings: PickerHeaderSettings(
                  headerBackgroundColor: Colors.indigo[300],
                  headerSelectedIntervalTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  headerPageTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  previousIcon: Icons.arrow_back,
                  nextIcon: Icons.arrow_forward,
                ),
                buttonsSettings: PickerButtonsSettings(
                  buttonBorder: const RoundedRectangleBorder(),
                  selectedMonthBackgroundColor: Colors.amber[900],
                  selectedMonthTextColor: Colors.white,
                  unselectedMonthsTextColor: Colors.black,
                  currentMonthTextColor: Colors.green,
                  yearTextStyle: const TextStyle(
                    color: Colors.amber,
                  ),
                  monthTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              rangeList: true,
            ).then((List<DateTime>? dates) {
              if (dates != null) {
                print(dates);
                print(dates.last.lastDayOfMonth());
              }
            });
          },
          child: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
