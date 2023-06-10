import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastHandler {
  showMyCustomToast(
    BuildContext context, {
    required Color backgroundColor,
    required Color color,
    required String text,
  }) async {
    showToast(
      text,
      context: context,
      shapeBorder: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      animation: StyledToastAnimation.slideFromBottomFade,
      reverseAnimation: StyledToastAnimation.slideToBottomFade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      borderRadius: BorderRadius.circular(5.0),
      textStyle: TextStyle(),
      backgroundColor: backgroundColor,
    );
  }
}
