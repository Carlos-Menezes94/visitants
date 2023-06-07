import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/login_controller.dart';

class InputDataLoginWidget extends StatefulWidget {
  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  const InputDataLoginWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<InputDataLoginWidget> createState() => _InputDataLoginWidgetState();
}

class _InputDataLoginWidgetState extends State<InputDataLoginWidget> {
  LoginController _controller = GetIt.I.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
