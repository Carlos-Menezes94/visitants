import '../../domain/entities/visitor_entity.dart';

class VisitorModel extends VisitorEntity {
  VisitorModel({
    required super.name,
    required super.cpf,
    required super.apVisited,
    required super.carPlate,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      name: json['nome'],
      cpf: json['cpf'],
      apVisited: json['ap_visitado'],
      carPlate: json['placa_do_carro'],
    );
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
