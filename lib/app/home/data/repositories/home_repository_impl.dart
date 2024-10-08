import 'package:dartz/dartz.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:visitants/app/home/domain/failures/cant_realize_of_login_failure.dart';
import 'package:visitants/core/response.dart';
import '../../../../../core/failure.dart';
import '../../../user_registration/data/models/user_registered_data_model.dart';
import '../../domain/failures/cant_created_new_visitor_failure.dart';
import '../../domain/failures/cant_get_list_visitors_failure.dart';
import '../../domain/failures/list_is_empty_failure.dart';
import '../../domain/repositories/home_repository_abstract.dart';
import '../data_sources/local/home_local_data_source_impl.dart';
import '../data_sources/remote/home_remote_data_source_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/visitor_model.dart';

class HomeRepositoryImpl implements HomeRepositoryAbstract {
  final HomeRemoteDataSourceImpl dataSourceRemote;
  final HomeLocalDataSourceImpl dataSourceLocal;

  HomeRepositoryImpl(
      {required this.dataSourceRemote, required this.dataSourceLocal});
  @override
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final DataSourceResponse response;

    try {
      if (connectivityResult == ConnectivityResult.none) {
        response = await dataSourceLocal.registerNewVisitorHive(visitor);
      } else {
        response = await dataSourceRemote.registerNewVisitorFirestore(visitor);
      }
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
    final connectivityResult = await (Connectivity().checkConnectivity());
    final DataSourceResponse response;

    try {
      if (connectivityResult == ConnectivityResult.none) {
        response = await dataSourceLocal.getListVisitorsLocal();
        final List<VisitorModel> visitors = response.data.cast<VisitorModel>();

        if (visitors.isNotEmpty) {
          return Right(visitors);
        } else {
          return Left(ListIsEmptyFailure());
        }
      } else {
        response = await dataSourceRemote.getListVisitors();
        List<VisitorModel> list = [];
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
      }
    } catch (error) {
      await Sentry.captureException(error);

      return Left(CantGetListVisitorsFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> adminCheckInRepository(
      {required String emailAdmin}) async {
    try {
      bool isCheckInVerify = false;
      final response = await dataSourceRemote.adminCheckInDataSource();

      List<UserRegisteredDataModel> users = response.data['lista']
          .map<UserRegisteredDataModel>(
              (item) => UserRegisteredDataModel.fromJson(item))
          .toList();

      if (users.isNotEmpty) {
        final user = users.firstWhere((user) {
          if (user.email == emailAdmin.trim()) {
            return user.isAdminUser!;
          }
          return false;
        });
        isCheckInVerify = user.isAdminUser!;
      }

      return Right(isCheckInVerify);
    } catch (error) {
      if (error is StateError) {
        return Left(CantNotAdminFailure());
      }
      return Left(throw UnimplementedError());
    }
  }
}
