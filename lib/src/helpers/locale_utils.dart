import 'package:flutter/widgets.dart';

///Function to get the selected locale code or the locale of context as a fallback
String getLocale(
  BuildContext context, {
  Locale? selectedLocale,
}) {
  // Function to create the locale string, including scriptCode if available
  String createLocaleString(Locale locale) {
    final languageCode = locale.languageCode;
    final scriptCode = locale.scriptCode ?? ''; // Default to empty if scriptCode is null
    final countryCode = locale.countryCode ?? ''; // Default to empty if countryCode is null

    if (scriptCode.isNotEmpty && countryCode.isNotEmpty) {
      return '${languageCode}_${scriptCode}_${countryCode}';
    } else if (scriptCode.isNotEmpty) {
      return '${languageCode}_${scriptCode}';
    } else if (countryCode.isNotEmpty) {
      return '${languageCode}_${countryCode}';
    } else {
      return languageCode;
    }
  }

  if (selectedLocale != null) {
    return createLocaleString(selectedLocale);
  }

  final Locale locale = Localizations.localeOf(context);
  return createLocaleString(locale);
}
