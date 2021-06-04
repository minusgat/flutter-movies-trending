
import '../entity/movie_detail_entity.dart';


abstract class MovieRepository{
  Future<List<MovieDetailEntity>> getTrending();
}