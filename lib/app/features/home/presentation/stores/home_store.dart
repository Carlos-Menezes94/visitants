import 'package:flutter/cupertino.dart';
import 'package:visitants/core/store.dart';

import '../../../../../core/app_state.dart';

class HomeStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());

  bool isContactResidentWhatsApp = false;
}
