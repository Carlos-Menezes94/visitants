import 'package:dartz/dartz.dart';
import '../../../../../core/failure.dart';
import '../../data/models/visitor_model.dart';
import '../../data/repositories/home_repository_impl.dart';

class GetListVisitorUsecase {
  final HomeRepositoryImpl repository;

  GetListVisitorUsecase({required this.repository});

  Future<Either<Failure, List<VisitorModel>>> getListVisitors() async {
    return repository.getListVisitors();
  }
}
