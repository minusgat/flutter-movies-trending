import 'package:equatable/equatable.dart';

class MovieDetailParams extends Equatable {
  final int id;
  final String language;

  const MovieDetailParams(this.id, this.language);

  @override
  List<Object> get props => [id,language];
}
