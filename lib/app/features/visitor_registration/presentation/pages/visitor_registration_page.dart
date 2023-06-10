import 'package:flutter/material.dart';
import 'package:visitants/app/features/visitor_registration/presentation/controllers/visitor_registration_controller.dart';
import 'package:visitants/app/features/visitor_registration/presentation/stores/visitor_registration_store.dart';
import 'package:visitants/app/features/visitor_registration/presentation/visitor_registration_module.dart';
import 'package:visitants/core/state.dart';

class VisitorRegistrationPage extends StatefulWidget {
  static const String routeName = '/VisitorRegistrationPage';

  // const VisitorRegistrationPage({super.key});
  const VisitorRegistrationPage({Key? key}) : super(key: key);

  @override
  State<VisitorRegistrationPage> createState() =>
      VisitorRegistrationPageState();
}

class VisitorRegistrationPageState extends StatePage<
    VisitorRegistrationModule,
    VisitorRegistrationPage,
    VisitorRegistrationController,
    VisitorRegistrationStore> {
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
            controller.clearTextField();
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
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.store.cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.store.visitLocationController,
                decoration: InputDecoration(labelText: 'Local a visitar'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um local';
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
