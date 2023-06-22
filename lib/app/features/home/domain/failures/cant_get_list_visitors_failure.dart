import 'package:visitants/core/failure.dart';

class CantGetListVisitorsFailure extends Failure {
  @override
  String get message => "Lista de visitantes vazia";
}
