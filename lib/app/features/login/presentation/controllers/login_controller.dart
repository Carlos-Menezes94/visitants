import 'package:visitants/app/features/login/domain/usecases/signin_login_use_case.dart';
import 'package:visitants/core/controller.dart';
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
