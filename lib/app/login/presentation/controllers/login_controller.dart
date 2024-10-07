import 'package:visitants/app/home/presentation/pages/home_page.dart';
import 'package:visitants/app/login/presentation/login_module.dart';
import 'package:visitants/core/controller.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/signin_login_use_case.dart';
import '../stores/login_store.dart';

class LoginController extends Controller {
  final LoginStore store;
  final SignInLoginUseCase signInLoginUseCase;
  final LogoutUseCase logoutUseCase;

  LoginController(
      {required this.signInLoginUseCase,
      required this.store,
      required this.logoutUseCase});

  void closeKeyboardOnOutsideClick() {
    store.focusNodeEmail.unfocus();
    store.focusNodePassword.unfocus();
  }

  loginSocial() async {
    final response = await signInLoginUseCase.socialLogin();

    response.fold(
      (l) {
        print(l.message);
      },
      (r) {
        print('sucesso');
        LoginModule.to.navigator.pushReplacementNamed(HomePage.routeName);
      },
    );
  }
}
