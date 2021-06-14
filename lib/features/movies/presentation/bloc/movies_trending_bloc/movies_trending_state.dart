part of 'movies_trending_cubit.dart';

class MoviesTrendingState extends Equatable {
  const MoviesTrendingState();

  @override
  List<Object> get props => [];
}

class MoviesTrendingInitial extends MoviesTrendingState {}

class MoviesTrendingError extends MoviesTrendingState {
  final AppErrorType errorType;

  const MoviesTrendingError(this.errorType);
}

class MoviesTrendingLoaded extends MoviesTrendingState {
  final List<MovieEntity> movies;
  final SupportedLanguage supportedLanguage;

  const MoviesTrendingLoaded(
      {required this.movies,
      required this.supportedLanguage});

  @override
  List<Object> get props => [movies,supportedLanguage];
}

class MoviesTrendingTranslatedLoaded extends MoviesTrendingState {
  final List<MovieEntity> movies;
  final SupportedLanguage supportedLanguage;

  const MoviesTrendingTranslatedLoaded(
      {required this.movies,
      required this.supportedLanguage});

  @override
  List<Object> get props => [movies,supportedLanguage];
}
