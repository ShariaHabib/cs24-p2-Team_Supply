import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';

import 'custom_filled_button.dart';

Future<dynamic> customDeleteDialog(BuildContext context, VoidCallback call) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
            size: 50,
          ),
          title: const Text("Delete"),
          content: const Text(
            "Are you sure?",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            CustomFilledButton(
                onPressed: call,
                buttonText: "Okay",
                filledColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.onPrimary),
            const SizedBox(
              height: kDefaultPadding * 0.5,
            ),
            CustomFilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonText: "Cancel",
                filledColor: Theme.of(context).colorScheme.primary,
                buttonTextColor: Theme.of(context).colorScheme.onPrimary),
          ],
        );
      });
}
