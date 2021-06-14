import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../entity/movie_detail_entity.dart';
import '../entity/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending(int page,String language);

  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id,String language);

  Future<Either<AppError, List<MovieEntity>>> getSearchedMovies(String query);
}
