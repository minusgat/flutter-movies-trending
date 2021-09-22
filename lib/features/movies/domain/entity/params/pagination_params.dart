class MovieDataBaseRequestParams {
  final int index;
  final int page;
  final String language;

  const MovieDataBaseRequestParams(
      {this.index = 1, this.page = 1, this.language = 'es'});

  get pageFactor => index ~/ 19 + 1;
}
