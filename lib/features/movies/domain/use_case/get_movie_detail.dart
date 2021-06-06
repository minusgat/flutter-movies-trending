import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/movie_detail_entity.dart';
import '../entity/movie_params.dart';
import '../repository/movie_repository.dart';
import 'use_case.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams> {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams params) async {
    return await repository.getMovieDetail(params.id);
  }
}
