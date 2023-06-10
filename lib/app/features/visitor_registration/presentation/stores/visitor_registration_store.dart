import 'package:flutter/cupertino.dart';
import 'package:visitants/core/store.dart';

import '../../data/models/visitor_model.dart';

class VisitorRegistrationStore extends Store {
  ValueNotifier<VisitorModel> visitorData = ValueNotifier<VisitorModel>(
      VisitorModel(name: "", cpf: "", apVisited: "", carPlate: ""));
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController visitLocationController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
}
