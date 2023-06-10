import 'package:flutter/material.dart';
import 'package:visitants/app/features/visitor_registration/domain/use_cases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/visitor_registration/presentation/stores/visitor_registration_store.dart';
import 'package:visitants/core/controller.dart';

import '../../../../../utils/toast.dart';
import '../../../login/presentation/login_module.dart';
import '../../data/models/visitor_model.dart';

class VisitorRegistrationController extends Controller {
  final CreateNewRegistrationVisitorUseCase usecase;
  final VisitorRegistrationStore store;

  VisitorRegistrationController({required this.usecase, required this.store});

  void registerNewVisitor(BuildContext context) async {
    VisitorModel newVisitor = VisitorModel(
      name: store.nameController.text,
      cpf: store.cpfController.text,
      apVisited: store.visitLocationController.text,
      carPlate: store.carPlateController.text,
    );

    final response = await usecase.registerVisitor(visitor: newVisitor);

    response.fold((failure) {
      return ToastHandler().showMyCustomToast(
        context,
        backgroundColor: Colors.yellowAccent.shade400,
        color: Colors.black,
        text: failure.message,
      );
    }, (sucess) {
      LoginModule.to.navigator.pop();

      return ToastHandler().showMyCustomToast(context,
          backgroundColor: Colors.greenAccent.shade400,
          color: Colors.black,
          text: "Visitante cadastrado com sucesso!");
    });
  }

  void clearTextField() {
    store.nameController.clear();
    store.cpfController.clear();
    store.visitLocationController.clear();
    store.carPlateController.clear();
  }
}
