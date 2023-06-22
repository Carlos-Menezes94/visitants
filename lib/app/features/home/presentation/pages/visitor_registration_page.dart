import 'package:flutter/material.dart';
import 'package:validadores/Validador.dart';
import 'package:visitants/app/features/home/presentation/controllers/home_controller.dart';
import 'package:visitants/app/features/home/presentation/home_module.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/core/state.dart';
import 'package:visitants/utils/masks/cpf_mask.dart';

class VisitorRegistrationPage extends StatefulWidget {
  static const String routeName = '/VisitorRegistrationPage';

  const VisitorRegistrationPage({Key? key}) : super(key: key);

  @override
  State<VisitorRegistrationPage> createState() =>
      VisitorRegistrationPageState();
}

class VisitorRegistrationPageState extends StatePage<HomeModule,
    VisitorRegistrationPage, HomeController, HomeStore> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      controller.registerNewVisitor(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Visitante'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // controller.clearTextField();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.store.nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '[Por favor, insira um nome]';
                  }
                  return null;
                },
              ),
              TextFormField(
                inputFormatters: [CPFMask.inputMask],
                controller: controller.store.cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  return Validador()
                      .add(Validar.CPF, msg: 'CPF Inválido')
                      .minLength(11)
                      .maxLength(11)
                      .valido(value, clearNoNumber: false);
                },
              ),
              TextFormField(
                controller: controller.store.visitLocationController,
                decoration: InputDecoration(labelText: 'Local à visitar'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '[Por favor, insira um local]';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.store.carPlateController,
                decoration: InputDecoration(labelText: 'Placa do carro'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
