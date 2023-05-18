import 'package:flutter/material.dart';
import '/src/helpers/controller.dart';

class PickerButtonBar extends StatelessWidget {
  const PickerButtonBar({
    super.key,
    required this.controller,
  });
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool useMaterial3 = theme.useMaterial3;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: () => controller.cancelFunction(context),
          child: controller.cancelWidget ??
              Text(useMaterial3
                  ? localizations.cancelButtonLabel
                  : localizations.cancelButtonLabel.toUpperCase()),
        ),
        TextButton(
          onPressed: () => controller.okFunction(context),
          child: controller.confirmWidget ??
              Text(useMaterial3
                  ? localizations.okButtonLabel
                  : localizations.okButtonLabel.toUpperCase()),
        )
      ],
    );
  }
}
