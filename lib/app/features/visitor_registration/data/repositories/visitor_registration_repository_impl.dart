import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/visitor_registration/data/data_sources/visitor_registration_data_source_impl.dart';

import '../../../../../core/failure.dart';
import '../../domain/failures/cant_created_new_visitor_failure.dart';
import '../../domain/repositories/visitor_registration_repository_abstract.dart';
import '../models/visitor_model.dart';

class VisitorRegistrationRepositoryImpl
    implements VisitorRegistrationRepositoryAbstract {
  final VisitorRegistrationDataSourceImpl dataSource;

  VisitorRegistrationRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, VisitorModel>> createdNewVisitor(
      {required VisitorModel visitor}) async {
    try {
      final response = await dataSource.registerNewVisitor(visitor);
      return Right(response);
    } catch (error) {
      return Left(CantCreateNewVisitorFailure());
    }
  }
}
