import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../commons/error/app_error.dart';
import '../../../domain/entity/movie_detail_entity.dart';
import '../../../domain/entity/params/movie_params.dart';
import '../../../domain/use_case/get_movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailCubit(this.getMovieDetail) : super(MovieDetailInitial());

  Future<void> loadTrending({int id = 0, String language = 'en'}) async {
    final MovieDetailParams paginationParams = MovieDetailParams(id, language);
    final moviesEither = await getMovieDetail(paginationParams);

    emit(
      moviesEither.fold(
        (l) => MovieDetailError(l.appErrorType),
        (movies) {
          return MovieDetailLoaded(movieDetailEntity: movies);
        },
      ),
    );
  }
}
