import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/login_controller.dart';

class InputDataLoginWidget extends StatefulWidget {
  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;

  final void Function(String) textTextField;
  const InputDataLoginWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.focusNode,
    required this.textTextField,
  }) : super(key: key);

  @override
  State<InputDataLoginWidget> createState() => _InputDataLoginWidgetState();
}

class _InputDataLoginWidgetState extends State<InputDataLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      onChanged: widget.textTextField,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
