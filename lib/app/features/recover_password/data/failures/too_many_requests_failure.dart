import 'package:visitants/core/failure.dart';

class TooManyRequestsFailure extends Failure {
  @override
  String get message => "Houve muitas solicitações para redefinir a senha para o mesmo usuário em um curto período de tempo";
}
