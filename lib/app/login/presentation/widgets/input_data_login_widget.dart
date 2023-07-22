import 'package:flutter/material.dart';

class InputDataLoginWidget extends StatefulWidget {
  final String labelText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Widget? suffixIcon;

  final void Function(String) textTextField;
  const InputDataLoginWidget({
    Key? key,
    required this.labelText,
    required this.suffixIcon,
    required this.controller,
    required this.focusNode,
    required this.textTextField,
    required this.textInputType,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<InputDataLoginWidget> createState() => _InputDataLoginWidgetState();
}

class _InputDataLoginWidgetState extends State<InputDataLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      controller: widget.controller,
      onChanged: widget.textTextField,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          suffixIcon: widget.suffixIcon),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
