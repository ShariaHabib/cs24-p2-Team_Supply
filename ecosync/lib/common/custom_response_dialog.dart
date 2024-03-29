import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/dashboard/controller/menu_controller.dart';
import 'custom_filled_button.dart';

Future<dynamic> customResponseDialog(
    BuildContext context, String title, String body,
    {bool isProfile = false}) {
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
                  if (isProfile == true) {
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
