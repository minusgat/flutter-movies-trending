import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/movie_detail_entity.dart';
import '../entity/params/movie_params.dart';
import '../repository/movies_repository.dart';
import 'use_case.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieDetailParams> {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(
      MovieDetailParams params) async {
    return await repository.getMovieDetail(params.id, params.language);
  }
}
