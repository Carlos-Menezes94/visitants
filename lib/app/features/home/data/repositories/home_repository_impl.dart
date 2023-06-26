import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import '../../../../../core/failure.dart';
import '../../domain/failures/cant_created_new_visitor_failure.dart';
import '../../domain/failures/cant_get_list_visitors_failure.dart';
import '../../domain/failures/list_is_empty_failure.dart';
import '../../domain/repositories/home_repository_abstract.dart';
import '../data_sources/local/home_local_data_source_impl.dart';
import '../data_sources/remote/home_remote_data_source_impl.dart';

class HomeRepositoryImpl implements HomeRepositoryAbstract {
  final HomeDataSourceImpl dataSource;
  final HomeLocalDataSourceImpl dataSourceLocal;

  HomeRepositoryImpl({required this.dataSource, required this.dataSourceLocal});
  @override
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor}) async {
    try {
      final response = await dataSourceLocal.registerNewVisitorHive(visitor);
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
        return Left(ListIsEmptyFailure());
      }
    } catch (error) {
      return Left(CantGetListVisitorsFailure());
    }
  }
}
