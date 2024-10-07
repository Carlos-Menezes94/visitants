import 'package:visitants/core/failure.dart';

class NetworkRequestFailedFailure extends Failure {
  @override
  String get message => "Houve uma falha na conexão de rede durante a tentativa de envio do e-mail de redefinição de senha.";
}
