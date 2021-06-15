import 'dart:convert';

import 'package:flutter_movies_trending/features/movies/data/core/api_client.dart';
import 'package:flutter_movies_trending/features/movies/data/core/unauthorised_exception.dart';
import 'package:flutter_movies_trending/features/movies/data/data_source/movie_data_source.dart';
import 'package:flutter_movies_trending/features/movies/data/model/movies_results_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements ApiClient {}

void main() {
  late MovieDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieDataSourceImpl(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(
      mockHttpClient.get('trending/movie/day', params: anyNamed('params')),
    ).thenAnswer((_) async => json.decode(fixture('movie_trending_es.json')));
  }

  void setUpMockHttpClientFailure() async{

    when(mockHttpClient.get('trending/movie/day', params: anyNamed('params')))
        .thenThrow(Exception());
  }

  group('getMovieTrending', () {
    final page = 1;
    final languageCode = 'es';
    final trendingResults = MoviesResultModel.fromJson(
            json.decode(fixture('movie_trending_es.json')))
        .results;

    test(
      '''should perform a GET request on a URL to find movies Trending''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getTrending(page, languageCode);
        // assert
        verify(
          mockHttpClient.get('trending/movie/day', params: anyNamed('params')),
        );
      },
    );

    test(
      'should return Movies list when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getTrending(page, languageCode);
        // assert
        expect(result, equals(trendingResults));
      },
    );

    test(
      'should throw a ServerException when something was wrong',
      () async {
        // arrange
        setUpMockHttpClientFailure();
        // act
        final result = dataSource.getTrending;
        // assert
        expect(() => result(page, languageCode),
            throwsA(TypeMatcher<Exception>()));
      },
    );
  });
}
