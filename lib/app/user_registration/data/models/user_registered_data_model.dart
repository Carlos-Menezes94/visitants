import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// part 'visitor_model.g.dart';

@HiveType(typeId: 1)
class UserRegisteredDataModel extends HiveObject {
  @HiveField(0)
  late String? name;

  @HiveField(1)
  late String? email;

  @HiveField(2)
  late String? password;

  @HiveField(3)
  late String? occupation;

  @HiveField(4)
  late String? dateTimeRegistration;

  @HiveField(5)
  late bool? isAdminUser;

  UserRegisteredDataModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.occupation,
      required this.dateTimeRegistration,
      required this.isAdminUser});

  factory UserRegisteredDataModel.fromJson(Map<String, dynamic> json) {
    return UserRegisteredDataModel(
        name: json['nome'] ?? " -- Empty -- ",
        email: json['email'] ?? " -- Empty -- ",
        password: json['password'] ?? " -- Empty -- ",
        occupation: json['occupation'] ?? " -- Empty -- ",
        dateTimeRegistration: json['dateTimeRegistration'] ?? " -- Empty -- ",
        isAdminUser: json['isAdminUser'] ?? false);
  }

  static List<UserRegisteredDataModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => UserRegisteredDataModel.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'email': email,
      'password': password,
      'occupation': occupation,
      'dateTimeRegistration': dateTimeRegistration,
      'isAdminUser': isAdminUser
    };
  }
}
