import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('User Registration'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.account_box),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.email),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              // your code
            })
      ],
    );
  }
}
