import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'visitor_model.g.dart';

@HiveType(typeId: 1)
class VisitorModel extends HiveObject {
  static const hiveBoxKey = "login_data";

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String cpf;

  @HiveField(2)
  late String apVisited;

  @HiveField(3)
  late String carPlate;

  @HiveField(4)
  late String dateTimeLastUpdate;

  @HiveField(5)
  late String dateTimeRegister;

  VisitorModel({
    required this.name,
    required this.cpf,
    required this.apVisited,
    required this.carPlate,
    required this.dateTimeLastUpdate,
    required this.dateTimeRegister,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      name: json['nome'],
      cpf: json['cpf'],
      apVisited: json['ap_visitado'],
      carPlate: json['placa_do_carro'],
      dateTimeLastUpdate: json['data_atualizacao'],
      dateTimeRegister: json['data_registro'],
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
      'data_atualizacao': dateTimeLastUpdate,
      'data_registro': dateTimeRegister,
    };
  }
}
