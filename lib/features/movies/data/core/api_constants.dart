class ApiConstants {
  ApiConstants._();

  static const movie_data_base_base_url = 'https://api.themoviedb.org/3/';
  static const movie_data_base_api_token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYzZhMjAzNzY4MmVkODcxY2QwNjlmMmQzMGQ2ODZhMSIsInN1YiI6IjYwYjc5Mzc2ODk5ZGEyMDA1OThmN2Y0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cBmcLo1S3gKvf6-AhE8Bnp1NGpenyZ6lgUHu8K3KfFs';
  static const movie_data_base_api_key ='0c6a2037682ed871cd069f2d30d686a1';
  static const movie_data_base_image_base_url =
      'https://image.tmdb.org/t/p/w500/';

  static var formatImageUrl =(url)=>'$movie_data_base_image_base_url$url';
}
