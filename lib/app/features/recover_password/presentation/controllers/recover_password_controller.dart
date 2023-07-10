import 'package:flutter/material.dart';
import 'package:visitants/core/controller.dart';

import '../../../../../utils/toast.dart';
import '../../domain/usecases/recover_password_usecase.dart';

class RecoverPasswordController extends Controller {
  final RecoverPasswordUseCase usecase;

  RecoverPasswordController({required this.usecase});

  Future<void> sendLinkRecoverPassword(BuildContext context) async {
    final response = await usecase.recoverPasswordUseCase(
        email: "menezes.carloseng@gmail.com");

    response.fold((failure) {
      print(failure.message);
      return ToastHandler().showMyCustomToast(
        context,
        backgroundColor: Colors.yellowAccent.shade400,
        color: Colors.black,
        text: failure.message,
      );
    }, (sucessSendLinkToRecoverPassword) {
      return sucessSendLinkToRecoverPassword;
    });
  }
}
