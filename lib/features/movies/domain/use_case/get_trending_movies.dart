import 'package:dartz/dartz.dart';
import 'package:flutter_movies_trending/features/movies/domain/entity/pagination_params.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/movie_entity.dart';
import '../repository/language_repository.dart';
import 'use_case.dart';

class GetTrending extends UseCase<List<MovieEntity>, MovieDataBaseRequestParams> {
  final MovieRepository repository;

  GetTrending(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      MovieDataBaseRequestParams movieDataBaseRequestParams) async {
    return await repository.getTrending(
        movieDataBaseRequestParams.pageFactor, movieDataBaseRequestParams.language);
  }
}
