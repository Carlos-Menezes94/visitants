import 'package:visitants/core/failure.dart';

class UserNotFoundFailure extends Failure {
  @override
  String get message => "Usuario não encontrado";
}
