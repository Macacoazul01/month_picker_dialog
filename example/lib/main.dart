import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void main() => runApp(MyApp(
      initialDate: DateTime.now(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialDate});
  final DateTime initialDate;

  @override
  _MyAppState createState() => _MyAppState();
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
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
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
              .copyWith(secondary: Colors.pinkAccent)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Month Picker Example App'),
        ),
        body: Center(
          child: Text(
            'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) => FloatingActionButton(
            onPressed: () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: selectedDate ?? widget.initialDate,
                locale: const Locale('en'),
                //show only even months
                selectableMonthPredicate: (DateTime val) => val.month.isEven,
                headerColor: Colors.amber[900],
                headerTextColor: Colors.black,
                selectedMonthBackgroundColor: Colors.amber[900],
                selectedMonthTextColor: Colors.white,
                unselectedMonthTextColor: Colors.green,
                confirmWidget: const Text(
                  'This one!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                cancelWidget: const Text('Cancel'),
                roundedCornersRadius: 20,
                //yearFirst: true,
                //forceSelectedDate: true,
                //dismissible: true,
                // capitalizeFirstLetter: true,
                // customHeight: 500,
                // customWidth: 500,
                // dismissible: true,
                // forceSelectedDate: true,
              ).then((DateTime? date) {
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              });
            },
            child: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}
