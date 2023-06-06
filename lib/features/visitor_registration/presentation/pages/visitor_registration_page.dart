import 'package:flutter/material.dart';

class VisitorRegistrationPage extends StatefulWidget {
  const VisitorRegistrationPage({super.key});

  @override
  State<VisitorRegistrationPage> createState() =>
      _VisitorRegistrationPageState();
}

class _VisitorRegistrationPageState extends State<VisitorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _visitLocationController = TextEditingController();
  TextEditingController _carPlateController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      // String name = _nameController.text;
      // String cpf = _cpfController.text;
      // String visitLocation = _visitLocationController.text;
      // String carPlate = _carPlateController.text;

      _nameController.clear();
      _cpfController.clear();
      _visitLocationController.clear();
      _carPlateController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulário enviado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Visitante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _visitLocationController,
                decoration: InputDecoration(labelText: 'Local a visitar'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um local';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carPlateController,
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
