import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../commons/error/app_error.dart';
import '../../domain/entity/movie_detail_entity.dart';
import '../../domain/repository/language_repository.dart';
import '../data_source/movie_data_source.dart';
import '../model/movie_model.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDataSource movieDataSource;

  MovieRepositoryImpl(this.movieDataSource);

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending(
      int page, String language) async {
    try {
      final movies = await movieDataSource.getTrending(page, language);
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(
      String searchTerm) async {
    try {
      final movies = await movieDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(
      int id, String language) async {
    try {
      final movieDetail = await movieDataSource.getMovieDetail(id);
      return Right(movieDetail);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
