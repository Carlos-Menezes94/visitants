import 'package:visitants/core/failure.dart';

class CantCreateNewVisitorFailure extends Failure {
  @override
  String get message => "Não foi possivel cadastrar";
}