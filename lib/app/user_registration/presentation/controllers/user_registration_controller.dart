import 'package:visitants/app/user_registration/domain/usecases/create_new_user_registration_use_case.dart';
import 'package:visitants/app/user_registration/presentation/stores/user_registration_store.dart';

import '../../../../core/controller.dart';

class UserRegistrationController extends Controller {
  final UserRegistrationStore store;
  final CreateNewUserRegistrationUseCase createNewUserRegistrationUseCase;

  UserRegistrationController(
      {required this.store, required this.createNewUserRegistrationUseCase});

  Future<void> createUserNew() async {
    final response =
        await createNewUserRegistrationUseCase.createNewUserRegistrationUseCase(
            email: store.email.text, password: store.password.text);

    response.fold((failure) {
      print("falhou");
    }, (sucess) {
      print("sucesso");
    });
  }
}
