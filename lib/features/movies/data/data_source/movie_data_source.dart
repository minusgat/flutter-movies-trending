import '../core/api_client.dart';
import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';
import '../model/movies_results_model.dart';

abstract class MovieDataSource {
  Future<List<MovieModel>> getTrending(int page, String language);

  Future<List<MovieModel>> getSearchedMovies(String query);

  Future<MovieDetailModel> getMovieDetail(int id);
}

class MovieDataSourceImpl extends MovieDataSource {
  final ApiClient _client;

  MovieDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending(int page, String language) async {
      final params = {'language': language, 'page': page};
      final response = await _client.get('trending/movie/day', params: params);
      var movies = MoviesResultModel.fromJson(response).results;
      return movies;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String query) async {

      final response = await _client.get('search/movie', params: {
        'query': query,
      });
      final movies = MoviesResultModel.fromJson(response).results;
      return movies;

  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    if (movie.id != -1 &&
        movie.title.isNotEmpty &&
        movie.posterPath.isNotEmpty) {
      return movie;
    }
    throw Exception();
  }
}
