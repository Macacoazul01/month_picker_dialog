import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

///The actions button bar. Where confirmation and cancel button are.
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
    final TextScaler? scaler =
        controller.monthPickerDialogSettings.dialogSettings.textScaleFactor != null
            ? TextScaler.linear(
                controller.monthPickerDialogSettings.dialogSettings.textScaleFactor!)
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
