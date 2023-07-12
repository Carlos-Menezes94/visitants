import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastHandler {
  showMyCustomToast(BuildContext context,
      {required String text, required bool isStateSucess}) async {
    showToast(
      text,
      context: context,
      shapeBorder: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      animation: StyledToastAnimation.slideFromBottomFade,
      reverseAnimation: StyledToastAnimation.slideToBottomFade,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      borderRadius: BorderRadius.circular(5.0),
      textStyle: const TextStyle(),
      backgroundColor: isStateSucess
          ? Colors.greenAccent.shade400
          : Colors.yellowAccent.shade400,
    );
  }
}
