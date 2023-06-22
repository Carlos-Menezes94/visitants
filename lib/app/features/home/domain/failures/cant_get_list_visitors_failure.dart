import 'package:visitants/core/failure.dart';

class CantGetListVisitorsFailure extends Failure {
  @override
  String get message => "Erro ao carregar lista de visitantes";
}
