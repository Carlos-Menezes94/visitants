import 'package:visitants/core/failure.dart';

class ErrorRecoverPasswordFailure extends Failure {
  @override
  String get message => "Ocorreu um erro ao tentar enviar link de redefinição de senha.";
}
