import 'package:visitants/core/failure.dart';

class InvalidEmailFailure extends Failure {
  @override
  String get message => "O endereço de e-mail fornecido é inválido ou malformatado";
}
