import 'package:flutter/material.dart';
import '/month_picker_dialog.dart';

///The actions button bar. Where confirmation and cancel button are.
class PickerActionBar extends StatelessWidget {
  const PickerActionBar({
    super.key,
    required this.controller,
  });
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final TextScaler? scaler =
        controller.monthPickerDialogSettings.dialogSettings.textScaleFactor !=
                null
            ? TextScaler.linear(controller
                .monthPickerDialogSettings.dialogSettings.textScaleFactor!)
            : null;
    return OverflowBar(
      spacing: controller.monthPickerDialogSettings.actionBarSettings.buttonSpacing,
      children: <Widget>[
        TextButton(
          onPressed: () => controller.cancelFunction(context),
          child: controller.monthPickerDialogSettings.actionBarSettings.cancelWidget ??
              Text(
                localizations.cancelButtonLabel,
                textScaler: scaler,
              ),
        ),
        TextButton(
          onPressed: () => controller.okFunction(context),
          child: controller.monthPickerDialogSettings.actionBarSettings.confirmWidget ??
              Text(
                localizations.okButtonLabel,
                textScaler: scaler,
              ),
        )
      ],
    );
  }
}
