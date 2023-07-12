import 'package:visitants/core/failure.dart';

class InternalNetworkFailure extends Failure {
  @override
  String get message => " Ocorreu um erro interno no servidor do Firebase Authentication.";
}
