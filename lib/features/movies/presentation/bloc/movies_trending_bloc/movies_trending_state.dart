part of 'movies_trending_cubit.dart';

class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesError extends MoviesState {
  final AppErrorType errorType;

  const MoviesError(this.errorType);


  @override
  List<Object> get props => [];

}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;
  final SupportedLanguage supportedLanguage;

  const MoviesLoaded(
      {required this.movies,
      required this.supportedLanguage});

  @override
  List<Object> get props => [movies,supportedLanguage];
}

class MoviesTrendingTranslatedLoaded extends MoviesState {
  final List<MovieEntity> movies;
  final SupportedLanguage supportedLanguage;

  const MoviesTrendingTranslatedLoaded(
      {required this.movies,
      required this.supportedLanguage});

  @override
  List<Object> get props => [movies,supportedLanguage];
}
