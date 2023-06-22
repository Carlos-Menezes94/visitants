
import 'package:visitants/app/features/home/domain/entities/visitor_entity.dart';

class VisitorModel extends VisitorEntity {
  VisitorModel({
    required String name,
    required String cpf,
    required String apVisited,
    required String carPlate,
  }) : super(name: name, cpf: cpf, apVisited: apVisited, carPlate: carPlate);

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      name: json['nome'],
      cpf: json['cpf'],
      apVisited: json['ap_visitado'],
      carPlate: json['placa_do_carro'],
    );
  }

  static List<VisitorModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VisitorModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'cpf': cpf,
      'ap_visitado': apVisited,
      'placa_do_carro': carPlate,
    };
  }
}
