import 'package:flutter/material.dart';
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
        title: const Text('Cadastro de Visitante'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.navigatorToHome,
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
                decoration: const InputDecoration(labelText: 'Nome'),
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
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '[Por favor, insira um CPF]';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.store.visitLocationController,
                decoration: const InputDecoration(labelText: 'Local à visitar'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '[Por favor, insira um local]';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.store.carPlateController,
                decoration: const InputDecoration(labelText: 'Placa do carro'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
