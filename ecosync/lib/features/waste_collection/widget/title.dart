import 'package:flutter/material.dart';

class BodyTitle extends StatelessWidget {
  const BodyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Waste Collection",
        style: Theme.of(context).textTheme.displaySmall);
  }
}
