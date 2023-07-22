import 'package:visitants/core/controller.dart';
import '../../domain/usecases/signin_login_use_case.dart';
import '../stores/login_store.dart';

class LoginController extends Controller {
  final LoginStore store;
  final SignInLoginUseCase signInLoginUseCase;

  LoginController({required this.signInLoginUseCase, required this.store});

  void closeKeyboardOnOutsideClick() {
    store.focusNodeEmail.unfocus();
    store.focusNodePassword.unfocus();
  }
}
