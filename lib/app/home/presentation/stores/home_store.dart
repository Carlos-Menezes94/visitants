import 'package:flutter/cupertino.dart';
import 'package:visitants/core/store.dart';
import '../../../../../core/app_state.dart';
import '../../data/models/visitor_model.dart';

class HomeStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());

  ValueNotifier<List<VisitorModel>> listVisitor = ValueNotifier([]);
  ValueNotifier<int> expandedItemIndex = ValueNotifier<int>(-1);
  bool isContactResidentWhatsApp = false;

  bool isExpanded = false;
  ValueNotifier<bool> isAdmin = ValueNotifier<bool>(false);

  ValueNotifier<VisitorModel> visitorData =
      ValueNotifier<VisitorModel>(VisitorModel(
    name: "",
    cpf: "",
    apVisited: "",
    carPlate: "",
    dateTimeRegister: '',
  ));
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController visitLocationController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
}
