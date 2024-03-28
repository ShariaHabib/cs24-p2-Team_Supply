import 'package:flutter/material.dart';

import 'custom_filled_button.dart';

Future<dynamic> customResponseDialog(
    BuildContext context, String title, String body) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
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
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                buttonText: "Okay",
                filledColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.onPrimary),
          ],
        );
      });
}
