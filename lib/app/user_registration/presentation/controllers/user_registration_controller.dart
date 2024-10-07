import 'package:flutter/material.dart';
import 'package:visitants/app/login/presentation/login_module.dart';
import 'package:visitants/app/user_registration/domain/usecases/create_new_user_registration_use_case.dart';
import 'package:visitants/app/user_registration/presentation/stores/user_registration_store.dart';

import '../../../../core/app_state.dart';
import '../../../../core/controller.dart';
import '../../../../utils/toast.dart';
import '../../../login/presentation/pages/login_page.dart';

class UserRegistrationController extends Controller {
  final UserRegistrationStore store;
  final CreateNewUserRegistrationUseCase createNewUserRegistrationUseCase;

  UserRegistrationController(
      {required this.store, required this.createNewUserRegistrationUseCase});

  Future<void> createUserNew(BuildContext context) async {
    store.userDataInformation.value.email = store.email.text;
    store.userDataInformation.value.password = store.password.text;
    store.userDataInformation.value.dateTimeRegistration =
        DateTime.now().toString();
    final response =
        await createNewUserRegistrationUseCase.createNewUserRegistrationUseCase(
            userRegisteredDataModel: store.userDataInformation.value);

    response.fold((failure) {
      return ToastHandler().showMyCustomToast(
        isStateSucess: false,
        context,
        text: "Não foi possivel cadastrar um novo usuário",
      );
    }, (sucess) {
      store.state.value = AppState.success();
      Future.delayed(const Duration(seconds: 5), () {
        LoginModule.to.navigator.pushNamed(LoginPage.routeName);
        store.state.value = AppState.idle();
        FocusScope.of(context).nextFocus();
        return ToastHandler().showMyCustomToast(
          isStateSucess: true,
          context,
          text: "Cadastro de novo usuário realizado!",
        );
      });

      _clearTextFieldUserRegistration();
    });
  }

  void _clearTextFieldUserRegistration() {
    store.userDataInformation.value.email = "";
    store.userDataInformation.value.password = "";
  }
}
