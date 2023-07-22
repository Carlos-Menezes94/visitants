import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/app/features/home/domain/usecases/admin_check_in_use_case.dart';
import 'package:visitants/app/features/home/domain/usecases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/home/domain/usecases/get_list_visitor_usecase.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/app_state.dart';
import 'package:visitants/core/controller.dart';

import '../../../../../utils/toast.dart';
import '../../../login/presentation/login_module.dart';
import '../pages/list_visitors_page.dart';

class HomeController extends Controller {
  final GetListVisitorUsecase getListVisitorUsecase;
  final CreateNewRegistrationVisitorUseCase createNewRegistrationVisitorUseCase;
  final HomeStore store;
  final LoginStore loginStore;
  final AdminCheckInUseCase adminCheckInUseCase;

  HomeController(
      {required this.adminCheckInUseCase,
      required this.getListVisitorUsecase,
      required this.loginStore,
      required this.createNewRegistrationVisitorUseCase,
      required this.store});

  void contactResident() {
    if (store.isContactResidentWhatsApp) {
      showWhatsApp();
    } else {
      showContacts();
    }
  }

  Future<void> getListVisitor(BuildContext context) async {
    store.state.value = AppState.loading();

    final response = await getListVisitorUsecase.getListVisitors();

    response.fold((failure) {
      store.state.value = AppState.error();

      return ToastHandler().showMyCustomToast(
        isStateSucess: false,
        context,
        text: failure.message,
      );
    }, (listVisitorsData) {
      store.state.value = AppState.success();
      listVisitorsData
          .sort((a, b) => b.dateTimeRegister!.compareTo(a.dateTimeRegister!));
      store.listVisitor.value = listVisitorsData;
      LoginModule.to.navigator.pushNamed(ListVisitorPage.routeName);
    });
  }

  void registerNewVisitor(BuildContext context) async {
    VisitorModel newVisitor = VisitorModel(
      name: store.nameController.text,
      cpf: store.cpfController.text,
      apVisited: store.visitLocationController.text,
      carPlate: store.carPlateController.text,
      dateTimeRegister: DateTime.now().toString(),
    );

    final response = await createNewRegistrationVisitorUseCase.registerVisitor(
        visitor: newVisitor);

    response.fold((failure) {
      return ToastHandler().showMyCustomToast(
        isStateSucess: false,
        context,
        text: failure.message,
      );
    }, (sucess) {
      navigatorToHome();
      return ToastHandler().showMyCustomToast(
          isStateSucess: true,
          text: "Visitante cadastrado com sucesso!",
          context);
    });
  }

  void navigatorToHome() {
    LoginModule.to.navigator.pop();
    clearTextField();
  }

  void showContacts() {
    final Uri uri = Uri(
      scheme: 'tel',
      path: '',
    );

    launch(uri.toString());
  }

  String? validCpf(String value) {
    // String textInput = value.toString().replaceAll('.', '').replaceAll('-', '');
    return null;
    // return Validador()
    //     .add(Validar.CPF, msg: 'CPF Inválido')
    //     .minLength(11)
    //     .maxLength(11)
    //     .valido(textInput, clearNoNumber: false);
  }

  void showWhatsApp() async {
    String message = 'Olá, aqui é da portaria.';

    String url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  void clearTextField() {
    store.nameController.clear();
    store.cpfController.clear();
    store.visitLocationController.clear();
    store.carPlateController.clear();
  }

  Future<void> adminCheckIn() async {
    store.state.value = AppState.loading();

    final response = await adminCheckInUseCase.adminCheckInUseCase(
        emailAdmin: loginStore.firebaseAuth.value.currentUser!.email!);

    response.fold((failure) {
      store.isAdmin = false;
      debugPrint(failure.message);
    }, (sucess) {
      store.isAdmin = sucess;
      store.state.value = AppState.success();
    });
  }
}
