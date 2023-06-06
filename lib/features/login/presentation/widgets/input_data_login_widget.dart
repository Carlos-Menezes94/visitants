import 'package:flutter/material.dart';

class InputDataLoginWidget extends StatefulWidget {
  final String labelText;
  const InputDataLoginWidget({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  State<InputDataLoginWidget> createState() => _InputDataLoginWidgetState();
}

class _InputDataLoginWidgetState extends State<InputDataLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onChanged: (value) {},
    );
  }
}
