import 'package:visitants/core/controller.dart';
import 'package:visitants/features/login/presentation/stores/login_store.dart';

class LoginController extends Controller {
  final LoginStore store;

  LoginController({required this.store});

  void closeKeyboardOnOutsideClick() {
    store.focusNodeEmail.unfocus();
    store.focusNodePassword.unfocus();
  }
}
