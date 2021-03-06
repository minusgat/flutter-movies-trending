import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movies_trending/commons/constants/languages_constants.dart';
import 'package:flutter_movies_trending/features/movies/data/model/movies_results_model.dart';

import 'package:flutter_movies_trending/features/movies/domain/entity/movie_entity.dart';
import 'package:flutter_movies_trending/features/movies/domain/entity/notification_entity.dart';
import 'package:flutter_movies_trending/features/movies/domain/entity/params/pagination_params.dart';
import 'package:flutter_movies_trending/features/movies/domain/use_case/get_movie_search.dart';
import 'package:flutter_movies_trending/features/movies/domain/use_case/get_trending_movies.dart';
import 'package:flutter_movies_trending/features/movies/presentation/bloc/language_bloc/language_cubit.dart';
import 'package:flutter_movies_trending/features/movies/presentation/bloc/loader_bloc/loader_cubit.dart';

import 'package:flutter_movies_trending/features/movies/presentation/bloc/movies_trending_bloc/movies_trending_cubit.dart';
import 'package:flutter_movies_trending/features/movies/presentation/bloc/notification_bloc/notification_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class LoaderCubitMock extends MockCubit<bool> implements LoaderCubit {}

class NotificationCubitMock extends MockCubit<NotificationState>
    implements NotificationCubit {}

class LanguageManagerCubitMock extends MockCubit<LanguageManagerState>
    implements LanguageManagerCubit {}

class GetTrendingMock extends Mock implements GetTrending {}

class MovieSearchMock extends Mock implements GetMovieSearch {}

void main() {
  var loaderCubitMock;
  var languageManagerCubitMock;
  var notificationCubitMock;
  var getTrendingMock;
  var movieSearchMock;

  late MoviesCubit moviesCubit;

  setUpAll(() {
    registerFallbackValue(
        LanguageManagerState(Languages.languageFromKey(SupportedLanguage.es)));

    registerFallbackValue(
      MoviesLoaded(movies: [
        MovieEntity(
            posterPath: 'posterPath',
            id: 1,
            backdropPath: 'backdropPath',
            title: 'title',
            voteAverage: 20,
            releaseDate: '')
      ], supportedLanguage: SupportedLanguage.es),
    );

    registerFallbackValue(NotificationLoaded(NotificationEntity()));

    registerFallbackValue(MovieDataBaseRequestParams(language: 'es'));

    loaderCubitMock = LoaderCubitMock();
    languageManagerCubitMock = LanguageManagerCubitMock();
    getTrendingMock = GetTrendingMock();
    notificationCubitMock = NotificationCubitMock();
    movieSearchMock = MovieSearchMock();

    moviesCubit = MoviesCubit(
      notificationCubit: notificationCubitMock,
      movieSearch: movieSearchMock,
      getTrending: getTrendingMock,
      languagesCubit: languageManagerCubitMock,
      loaderCubit: loaderCubitMock,
    );
  });

  tearDown(() {
    loaderCubitMock.close();
    languageManagerCubitMock.close();
    getTrendingMock.close();
  });

  group('movieTrendingBloc test', () {
    test('initial state should be [MoviesTrendingInitial]', () {
      expect(moviesCubit.state.runtimeType, MoviesInitial);
    });

    blocTest(
      'should load movie success',

      build: () => moviesCubit,
      act: (MoviesCubit bloc) async {
        final trendingResults = MoviesResultModel.fromJson(
                json.decode(fixture('movie_trending_es.json')))
            .results;

        //arrange
        when(getTrendingMock.call(MovieDataBaseRequestParams(language: 'es')))
            //We use Right because 'call' is an Either Object
            .thenAnswer((_) async => Right(trendingResults));
        //act
        bloc.loadTrending();
      },
      // assert
      expect: () => isA<MoviesLoaded>(),
    );

    blocTest(
      'should load Error',

      build: () => moviesCubit,
      act: (MoviesCubit bloc) async {
        final trendingResults = MoviesResultModel.fromJson(
                json.decode(fixture('movie_trending_es.json')))
            .results;

        //arrange
        when(getTrendingMock.call(MovieDataBaseRequestParams(language: 'es')))
            //We use Left because 'call' is an Either Object
            .thenAnswer((_) async => Left(trendingResults));
        //act
        bloc.loadTrending();
      },
      // assert
      expect: () => isA<MoviesLoaded>(),
    );
  });
}
