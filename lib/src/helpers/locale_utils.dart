import 'package:flutter/widgets.dart';

///Function to get the selected locale code or the locale of context as a fallback
String getLocale(
  BuildContext context, {
  Locale? selectedLocale,
}) {
  if (selectedLocale != null) {
    return '${selectedLocale.languageCode}_${selectedLocale.countryCode}';
  }
  final Locale locale = Localizations.localeOf(context);
  return '${locale.languageCode}_${locale.countryCode}';
}
