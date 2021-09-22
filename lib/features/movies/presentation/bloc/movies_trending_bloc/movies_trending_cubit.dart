import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../commons/constants/languages_constants.dart';
import '../../../../../commons/error/app_error.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../../domain/entity/params/pagination_params.dart';
import '../../../domain/use_case/get_movie_search.dart';
import '../../../domain/use_case/get_trending_movies.dart';
import '../language_bloc/language_cubit.dart';
import '../loader_bloc/loader_cubit.dart';
import '../notification_bloc/notification_cubit.dart';

part 'movies_trending_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final LoaderCubit loaderCubit;
  final GetTrending getTrending;
  final GetMovieSearch movieSearch;
  final LanguageManagerCubit languagesCubit;
  final NotificationCubit notificationCubit;

  MoviesCubit({
    required this.movieSearch,
    required this.getTrending,
    required this.languagesCubit,
    required this.loaderCubit,
    required this.notificationCubit,
  }) : super(MoviesInitial());

  //Dispatch when we need retrieve Movie trending
  Future<void> loadTrending({int cursorIndex = 1, pageIndex = 1}) async {
    loaderCubit.toggleLoader(true);

    final actualLanguage = languagesCubit.state.language.code;

    final MovieDataBaseRequestParams paginationParams =
        MovieDataBaseRequestParams(
            index: cursorIndex, page: pageIndex, language: actualLanguage);

    final moviesEither = await getTrending(paginationParams);

    emit(
      moviesEither.fold(
        throwError,
        handleSuccess,
      ),
    );
    loaderCubit.toggleLoader(false);
  }

  //Dispatch when a Language state change
  Future<void> loadTrendingTranslation() async {
    loaderCubit.toggleLoader(true);

    final actualLanguage = languagesCubit.state.language.code;
    final MovieDataBaseRequestParams paginationParams =
        MovieDataBaseRequestParams(language: actualLanguage);

    final moviesEither = await getTrending(paginationParams);

    emit(
      moviesEither.fold(
        throwError,
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

  MoviesState throwError(AppError appError) {
    notificationCubit.showError(appError.appErrorType);
    return MoviesError(appError.appErrorType);
  }

  MoviesState handleSuccess(List<MovieEntity> movies) {
    return MoviesLoaded(
        movies: movies,
        supportedLanguage: Languages.languageFromCode(
          languagesCubit.state.language.code,
        ).key);
  }
}
