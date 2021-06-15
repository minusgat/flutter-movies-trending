import 'dart:convert';

import 'package:flutter_movies_trending/features/movies/data/model/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {

  final movieModel = MovieModel(
    id: 299534,
    title: 'Avengers: Endgame',
    backdropPath: '/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg',
    posterPath: '/br6krBFpaYmCSglLBWRuhui7tPc.jpg',
  );

  test(
    'should be a subclass of Movie entity',
    () async {
      // assert
      expect(movieModel, isA<MovieModel>());
    },
  );

  group('fromJson', () {

    test(
      'should return a valid model when the ID number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('movie_model.json'));
        // act
        final result = MovieModel.fromJson(jsonMap);
        // assert
        expect(result, movieModel);
      },
    );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = movieModel.toJson();
        // assert
        final expectedMap = {
          'id': 299534,
          'video': null,
          'vote_count': null,
          'vote_average': null,
          'title': 'Avengers: Endgame',
          'release_date': null,
          'original_language': null,
          'original_title': null,
          'genre_ids': null,
          'backdrop_path': '/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg',
          'adult': null,
          'overview': null,
          'poster_path': '/br6krBFpaYmCSglLBWRuhui7tPc.jpg',
          'popularity': null,
          'media_type': null
        };
        expect(result, expectedMap);
      },
    );
  });
}
