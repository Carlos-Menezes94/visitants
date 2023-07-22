import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';

import '../../../../../core/failure.dart';

abstract class HomeRepositoryAbstract {
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor});

  Future<Either<Failure, List<VisitorModel>>> getListVisitors();
  Future<Either<Failure, bool>> adminCheckInRepository(
      {required String emailAdmin});
}
