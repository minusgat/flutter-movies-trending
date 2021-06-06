import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/movie_entity.dart';
import '../entity/movie_search_params.dart';
import '../repository/movie_repository.dart';
import 'use_case.dart';

class GetMovieSearch extends UseCase<List<MovieEntity>, MovieSearchParams> {
  final MovieRepository repository;

  GetMovieSearch(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      MovieSearchParams params) async {
    return await repository.getSearchedMovies(params.query);
  }
}
