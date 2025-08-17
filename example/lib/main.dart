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
          dialogTheme: const DialogThemeData(
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
  int? selectedYear;
  List<DateTime> rangeDates = [];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedYear = selectedDate?.year;
  }

  Future<void> monthPicker(BuildContext contexto) async {
    return showMonthPicker(
      context: contexto,
      firstDate: DateTime(DateTime.now().year - 5, 5),
      lastDate: DateTime(DateTime.now().year + 8, 9),
      initialDate: selectedDate ?? widget.initialDate,
      selectableMonthPredicate: (DateTime val) => val.month.isEven,
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
      monthPickerDialogSettings: MonthPickerDialogSettings(
        // dialogSettings: const PickerDialogSettings(blockScrolling: false),
        headerSettings: const PickerHeaderSettings(
          headerCurrentPageTextStyle: TextStyle(fontSize: 14),
          headerSelectedIntervalTextStyle: TextStyle(fontSize: 16),
        ),
        actionBarSettings: PickerActionBarSettings(
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
        ),
      ),
    ).then((DateTime? date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
        });
      }
    });
  }

  Future<void> yearPicker(BuildContext contexto) async {
    return showYearPicker(
            context: contexto,
            firstDate: DateTime(DateTime.now().year - 5, 5),
            lastDate: DateTime(DateTime.now().year + 8, 9),
            initialDate: DateTime(selectedYear ?? DateTime.now().year),
            selectableYearPredicate: (int year) => year.isEven,
            monthPickerDialogSettings: const MonthPickerDialogSettings(
                dialogSettings: PickerDialogSettings(yearsPerPage: 20)))
        .then((int? year) {
      if (year != null) {
        setState(() {
          selectedYear = year;
        });
      }
    });
  }

  Future<void> rangePicker(BuildContext contexto) async {
    return showMonthRangePicker(
      context: contexto,
      returnToStartofRange: true,
      firstDate: DateTime(DateTime.now().year - 5, 5),
      lastDate: DateTime(DateTime.now().year + 8, 9),
      initialRangeDate:
          rangeDates.firstOrNull ?? DateTime(DateTime.now().year - 1, 5),
      endRangeDate:
          rangeDates.lastOrNull ?? DateTime(DateTime.now().year - 1, 7),
      headerTitle: const Text('Month Picker Dialog'),
      monthPickerDialogSettings: MonthPickerDialogSettings(
        dialogSettings: PickerDialogSettings(
          locale: const Locale('en'),
          dialogRoundedCornersRadius: 20,
          dialogBackgroundColor: Colors.red[50],
          // blockScrolling: false,
        ),
        actionBarSettings: PickerActionBarSettings(
          actionBarPadding: const EdgeInsets.only(right: 20),
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
        ),
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: Colors.indigo[300],
          headerSelectedIntervalTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headerCurrentPageTextStyle: const TextStyle(
            color: Colors.black,
          ),
          previousIcon: Icons.arrow_back,
          nextIcon: Icons.arrow_forward,
        ),
        dateButtonsSettings: PickerDateButtonsSettings(
          buttonBorder: const RoundedRectangleBorder(),
          selectedMonthBackgroundColor: Colors.amber[900],
          selectedMonthTextColor: Colors.white,
          unselectedMonthsTextColor: Colors.black,
          currentMonthTextColor: Colors.green,
          yearTextStyle: const TextStyle(
            fontSize: 10,
          ),
          monthTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      rangeList: true,
      onMonthSelected: (DateTime date) {
        print('Selected month: ${date.toIso8601String()}');
      },
      onYearSelected: (int date) {
        print('Selected year: $date');
      },
    ).then((List<DateTime>? dates) {
      if (dates != null && dates.isNotEmpty) {
        setState(() {
          rangeDates = dates;
        });
      }
    });
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
                TextButton(
                  onPressed: () async => await monthPicker(context),
                  child: const Text('Single month picker'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () async => await yearPicker(context),
                  child: const Text('Single year picker'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Year: $selectedYear',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Selected range: ${rangeDates.map((dateTime) {
                    return dateTime.toIso8601String().split('T').first;
                  }).join(', ')}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) => FloatingActionButton(
          onPressed: () async => await rangePicker(context),
          child: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
