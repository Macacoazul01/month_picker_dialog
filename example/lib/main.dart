import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_picker_dialog_2/month_picker_dialog.dart';

void main() => runApp(MyApp(
      initialDate: DateTime.now(),
    ));

class MyApp extends StatefulWidget {
  final DateTime initialDate;

  const MyApp({Key? key, required this.initialDate}) : super(key: key);

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
      ],
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('ru'),
        Locale('ja'),
        Locale('ar'),
        Locale('fa'),
        Locale("es"),
        Locale("it"),
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.pinkAccent)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Month Picker Example App'),
        ),
        body: Center(
          child: Text(
            'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: selectedDate ?? widget.initialDate,
                locale: Locale("en"),
                //show only even months
                selectableMonthPredicate: (DateTime val) => val.month.isEven,
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
        ),
      ),
    );
  }
}
