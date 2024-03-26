import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.isSecured = false,
  });
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isSecured;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSecured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.labelText,
          suffixIcon: widget.isSecured
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                )
              : const SizedBox()),
    );
  }
}
