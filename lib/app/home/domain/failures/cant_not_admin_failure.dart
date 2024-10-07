import 'package:visitants/core/failure.dart';

class CantNotAdminFailure extends Failure {
  @override
  String get message => "Usuário não ADMIN";
}
