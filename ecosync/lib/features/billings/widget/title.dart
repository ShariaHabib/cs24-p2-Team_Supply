import 'package:flutter/material.dart';

class BodyTitle extends StatelessWidget {
  const BodyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Automated Billing",
        style: Theme.of(context).textTheme.displaySmall);
  }
}
