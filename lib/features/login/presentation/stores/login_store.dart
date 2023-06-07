import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/store.dart';

class LoginStore extends Store {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
}
