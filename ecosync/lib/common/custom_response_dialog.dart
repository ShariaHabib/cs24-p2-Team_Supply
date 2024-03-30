import 'package:flutter/material.dart';
import 'custom_filled_button.dart';

Future<dynamic> customResponseDialog(
    BuildContext context, String title, String body,
    {bool isProfile = false, bool isError = false}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: isError
              ? const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                )
              : const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
          title: Text(title),
          content: Text(
            body,
            textAlign: TextAlign.center,
          ),
          actions: [
            CustomFilledButton(
                onPressed: () {
                  if (isProfile == true || isError == true) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
                buttonText: "Okay",
                filledColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.onPrimary),
          ],
        );
      });
}
