import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CPFMask {
  static const _mask = r'###.###.###-##';
  static get length => _mask.length;

  static String maskText(String text) {
    return MaskTextInputFormatter(mask: _mask, filter: {'#': RegExp(r'[0-9]')})
        .maskText(text);
  }

  static TextInputFormatter get inputMask =>
      MaskTextInputFormatter(mask: _mask, filter: {'#': RegExp(r'[0-9]')});
}
