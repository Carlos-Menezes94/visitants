import 'package:flutter/material.dart';
import 'package:visitants/core/controller.dart';
import '../../../../../core/app_state.dart';
import '../../../../../utils/toast.dart';
import '../../../login/presentation/login_module.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../domain/usecases/recover_password_usecase.dart';
import '../stores/recover_password_store.dart';

class RecoverPasswordController extends Controller {
  final RecoverPasswordUseCase usecase;
  final RecoverPasswordStore store;

  RecoverPasswordController({required this.store, required this.usecase});

  Future<void> sendLinkRecoverPassword(BuildContext context) async {
    store.state.value = AppState.loading();

    final response = await usecase.recoverPasswordUseCase(
        email: store.emailTextToRecoverPassword);

    response.fold((failure) {
      store.state.value = AppState.error();

      print(failure.message);
      return ToastHandler().showMyCustomToast(
        isStateSucess: false,
        context,
        text: failure.message,
      );
    }, (sucessSendLinkToRecoverPassword) {
      store.state.value = AppState.success();
      Future.delayed(const Duration(seconds: 5), () {
        LoginModule.to.navigator.pushNamed(LoginPage.routeName);

        store.state.value = AppState.idle();
        return ToastHandler().showMyCustomToast(
          isStateSucess: true,
          context,
          text:
              "Foi enviado um link para redefinir sua senha, acesse a caixa de entrada",
        );
      });

      return sucessSendLinkToRecoverPassword;
    });
  }
}
