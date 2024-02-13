import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

class PickerButtonBar extends StatelessWidget {
  const PickerButtonBar({
    super.key,
    required this.controller,
  });
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final TextScaler? scaler = controller.textScaleFactor != null
        ? TextScaler.linear(controller.textScaleFactor!)
        : null;
    return ButtonBar(
      children: <Widget>[
        TextButton(
          onPressed: () => controller.cancelFunction(context),
          child: controller.cancelWidget ??
              Text(
                localizations.cancelButtonLabel,
                textScaler: scaler,
              ),
        ),
        TextButton(
          onPressed: () => controller.okFunction(context),
          child: controller.confirmWidget ??
              Text(
                localizations.okButtonLabel,
                textScaler: scaler,
              ),
        )
      ],
    );
  }
}
