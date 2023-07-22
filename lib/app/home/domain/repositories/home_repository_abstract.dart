import 'package:dartz/dartz.dart';
import '../../../../../core/failure.dart';
import '../../data/models/visitor_model.dart';

abstract class HomeRepositoryAbstract {
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor});

  Future<Either<Failure, List<VisitorModel>>> getListVisitors();
  Future<Either<Failure, bool>> adminCheckInRepository(
      {required String emailAdmin});
}
