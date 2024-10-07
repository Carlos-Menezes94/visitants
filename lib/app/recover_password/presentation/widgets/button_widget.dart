import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  const ButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: onPressed,
            child: const Text(
              "Enviar",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
