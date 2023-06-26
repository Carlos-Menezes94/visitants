import 'package:flutter/cupertino.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/store.dart';

import '../../../../../core/app_state.dart';

class HomeStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());

  ValueNotifier<List<VisitorModel>> listVisitor = ValueNotifier([]);
  ValueNotifier<int> expandedItemIndex = ValueNotifier<int>(-1);
  bool isContactResidentWhatsApp = false;

  bool isExpanded = false;
  // int expandedItemIndex = -1;

  ValueNotifier<VisitorModel> visitorData = ValueNotifier<VisitorModel>(
      VisitorModel(
          name: "",
          cpf: "",
          apVisited: "",
          carPlate: "",
          dateTimeLastUpdate: '',
          dateTimeRegister: ''));
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController visitLocationController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
}
