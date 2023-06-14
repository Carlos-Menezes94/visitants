import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/home/data/data_sources/home_data_source_impl.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import '../../../../../core/failure.dart';
import '../../domain/failures/cant_created_new_visitor_failure.dart';
import '../../domain/repositories/home_repository_abstract.dart';

class HomeRepositoryImpl implements HomeRepositoryAbstract {
  final HomeDataSourceImpl dataSource;

  HomeRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor}) async {
    try {
      final response = await dataSource.registerNewVisitor(visitor);
      if (response.success) {
        return Right(response.data.toString());
      } else {
        return Left(CantCreateNewVisitorFailure());
      }
    } catch (error) {
      return Left(CantCreateNewVisitorFailure());
    }
  }

  @override
  Future<Either<Failure, List<VisitorModel>>> getListVisitors() async {
    try {
      List<VisitorModel> list = [];
      final response = await dataSource.getListVisitors();
      final data = response.data;
      final lista = data?['lista'] as List<dynamic>?;

      for (var item in lista!) {
        if (item is Map<String, dynamic>) {
          VisitorModel visitor = VisitorModel.fromJson(item);
          list.add(visitor);
        }
      }
      if (list.isNotEmpty) {
        return Right(list);
      } else {
        return Left(CantCreateNewVisitorFailure());
      }
    } catch (error) {
      return Left(CantCreateNewVisitorFailure());
    }
  }
}
