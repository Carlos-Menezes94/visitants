import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/app/features/home/domain/usecases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/home/domain/usecases/get_list_visitor_usecase.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/controller.dart';

import '../../../../../utils/toast.dart';
import '../../../login/presentation/login_module.dart';
import '../pages/list_visitor_page.dart';

class HomeController extends Controller {
  final GetListVisitorUsecase getListVisitorUsecase;
  final CreateNewRegistrationVisitorUseCase createNewRegistrationVisitorUseCase;
  final HomeStore store;
  final LoginStore loginStore;

  HomeController(
      {required this.getListVisitorUsecase,
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

  // Future<void> getList() async {
  //   final collectionVisitorsTable =
  //       FirebaseFirestore.instance.collection('tabela_pessoas');
  //   final docRef = collectionVisitorsTable.doc('cadastrados');
  //   store.listVisitor.value = [];
  //   final documentSnapshot = await docRef.get();
  //   if (documentSnapshot.exists) {
  //     final data = documentSnapshot.data();
  //     final lista = data?['lista'] as List<dynamic>?;

  //     if (lista != null) {
  //       for (final item in lista) {
  //         if (item is Map<String, dynamic>) {
  //           VisitorModel visitor = VisitorModel.fromJson(item);
  //           store.listVisitor.value.add(visitor);
  //         }
  //       }
  //       LoginModule.to.navigator.pushNamed(ListVisitorPage.routeName);
  //       print(store.listVisitor.value);
  //       // Faça o que você precisa com a lista de visitantes
  //       // ...
  //     } else {
  //       print('A lista de visitantes não foi encontrada.');
  //     }
  //   } else {
  //     print('Documento não encontrado.');
  //   }
  // }

  Future<void> getListVisitor() async {
    final response = await getListVisitorUsecase.getListVisitors();

    response.fold((failure) {
      print(failure);
    }, (sucess) {
      store.listVisitor.value = sucess;
      print(sucess);
      LoginModule.to.navigator.pushNamed(ListVisitorPage.routeName);
    });
  }

  void registerNewVisitor(BuildContext context) async {
    VisitorModel newVisitor = VisitorModel(
      name: store.nameController.text,
      cpf: store.cpfController.text,
      apVisited: store.visitLocationController.text,
      carPlate: store.carPlateController.text,
    );

    final response = await createNewRegistrationVisitorUseCase.registerVisitor(
        visitor: newVisitor);

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

  void showContacts() {
    final Uri uri = Uri(
      scheme: 'tel',
      path: '',
    );

    launch(uri.toString());
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
}
