part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final AppErrorType errorType;

  const MovieDetailError(this.errorType);
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailLoaded({
    required this.movieDetailEntity,
  });

  @override
  List<Object> get props => [movieDetailEntity];
}
