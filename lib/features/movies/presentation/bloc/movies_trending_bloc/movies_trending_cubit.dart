import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_trending/features/movies/domain/entity/pagination_params.dart';
import 'package:flutter_movies_trending/features/movies/presentation/bloc/language_bloc/language_cubit.dart';
import 'package:flutter_movies_trending/features/movies/presentation/bloc/loader_cubit/loader_cubit.dart';
import '../../../../../commons/constants/languages_constants.dart';
import '../../../../../commons/error/app_error.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../../domain/use_case/get_trending_movies.dart';

part 'movies_trending_state.dart';

class MoviesTrendingCubit extends Cubit<MoviesTrendingState> {
  final LoaderCubit loaderCubit;
  final GetTrending getTrending;
  final LanguageManagerCubit languagesCubit;

  MoviesTrendingCubit({
    required this.getTrending,
    required this.languagesCubit,
    required this.loaderCubit,
  }) : super(MoviesTrendingInitial());

  Future<void> loadTrending({int cursorIndex = 1, pageIndex = 1}) async {
    loaderCubit.toggleLoader(true);

    final actualLanguage = languagesCubit.state.language.code;
    final MovieDataBaseRequestParams paginationParams =
        MovieDataBaseRequestParams(
            index: cursorIndex, page: pageIndex, language: actualLanguage);

    final moviesEither = await getTrending(paginationParams);

    emit(
      moviesEither.fold(
        (l) => MoviesTrendingError(l.appErrorType),
        (movies) {
          return MoviesTrendingLoaded(
              movies: movies,
              supportedLanguage: Languages.languageFromCode(
                languagesCubit.state.language.code,
              ).key);
        },
      ),
    );
    loaderCubit.toggleLoader(false);
  }

  Future<void> loadTrendingTranslation() async {
    loaderCubit.toggleLoader(true);

    final actualLanguage = languagesCubit.state.language.code;
    final MovieDataBaseRequestParams paginationParams =
        MovieDataBaseRequestParams(language: actualLanguage);

    final moviesEither = await getTrending(paginationParams);

    emit(
      moviesEither.fold(
        (l) => MoviesTrendingError(l.appErrorType),
        (movies) {
          return MoviesTrendingTranslatedLoaded(
            movies: movies,
            supportedLanguage: Languages.languageFromCode(
              languagesCubit.state.language.code,
            ).key,
          );
        },
      ),
    );
    loaderCubit.toggleLoader(false);
  }
}
