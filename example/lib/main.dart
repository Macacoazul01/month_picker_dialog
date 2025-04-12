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
          //Changing the global dialo g border
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
  int? selectedYear;
  List<DateTime> rangeDates = [];
  Time time = Time(time: 1, year: DateTime.now().year);
  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedYear = selectedDate?.year;
  }

  Future<void> monthPicker(BuildContext contexto) async {
    return showWeekPicker(
      context: contexto,
      firstDate: DateTime.now().copyWith(year: 2000),
      lastDate: DateTime.now().copyWith(year: 2100),
      initTime: time,
      selectableYearPredicate: (int year) => year.isEven,
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
      monthPickerDialogSettings: const MonthPickerDialogSettings(
        dialogSettings: PickerDialogSettings(
          customHeight: 360
        ),
        headerSettings: PickerHeaderSettings(
          headerCurrentPageTextStyle: TextStyle(fontSize: 14),
          headerSelectedIntervalTextStyle: TextStyle(fontSize: 16),
        ),
      ),
    ).then(( date) {
      setState(() {
        time= date!;
        // selectedDate = DateTime.now().copyWith(year: date);
      });
      print('${date}');
    });
  }

  Future<void> yearPicker(BuildContext contexto) async {
    return showYearPicker(
      context: contexto,
      firstDate: DateTime(DateTime.now().year - 5, 5),
      lastDate: DateTime(DateTime.now().year + 8, 9),
      initialDate: DateTime(selectedYear ?? DateTime.now().year),
      selectableYearPredicate: (int year) => year.isEven,
    ).then((int? year) {
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
          dialogBackgroundColor: Colors.blueGrey[50],
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
