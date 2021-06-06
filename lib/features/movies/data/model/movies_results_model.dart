import 'dart:convert';

import 'movie_model.dart';

MoviesResultModel moviesResultModelFromJson(String str) =>
    MoviesResultModel.fromJson(json.decode(str));

String moviesResultModelToJson(MoviesResultModel data) =>
    json.encode(data.toJson());

class MoviesResultModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MoviesResultModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        page: json["page"],
        results: List<MovieModel>.from(
          json["results"].map(
            (x) => MovieModel.fromJson(x),
          ),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
