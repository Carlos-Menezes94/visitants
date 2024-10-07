import 'package:visitants/core/failure.dart';

class CantNotAdminFailure extends Failure {
  @override
  String get message => "falha ao realizar o login do usuário";
}
