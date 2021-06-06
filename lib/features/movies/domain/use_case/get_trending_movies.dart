import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/empty_params.dart';
import '../entity/movie_entity.dart';
import '../repository/movie_repository.dart';
import 'use_case.dart';

class GetTrending extends UseCase<List<MovieEntity>, EmptyParams> {
  final MovieRepository repository;

  GetTrending(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      EmptyParams emptyParams) async {
    return await repository.getTrending();
  }
}
