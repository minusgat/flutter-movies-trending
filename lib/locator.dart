import 'package:flutter_movies_trending/features/movies/presentation/bloc/loader_bloc/loader_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'features/movies/data/core/api_client.dart';
import 'features/movies/data/data_source/movie_data_source.dart';
import 'features/movies/data/repository/movies_repository_impl.dart';
import 'features/movies/domain/repository/language_repository.dart';
import 'features/movies/domain/use_case/get_movie_search.dart';
import 'features/movies/domain/use_case/get_trending_movies.dart';
import 'features/movies/presentation/bloc/language_bloc/language_cubit.dart';
import 'features/movies/presentation/bloc/movies_trending_bloc/movies_trending_cubit.dart';
import 'features/movies/presentation/bloc/notification_bloc/notification_cubit.dart';

final locator = GetIt.instance;

void setUpDI() {
  // Bloc
  locator.registerFactory(
    () => LoaderCubit(),
  );

  locator.registerFactory(
    () => NotificationCubit(),
  );

  locator.registerFactory(
    () => LanguageManagerCubit(
      loaderCubit: locator(),
    ),
  );

  locator.registerFactory(
    () => MoviesCubit(
      movieSearch: locator(),
      getTrending: locator(),
      notificationCubit: locator(),
      loaderCubit: locator(),
      languagesCubit: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => GetTrending(locator()));
  locator.registerLazySingleton(() => GetMovieSearch(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(locator()),
  );

  // Data sources
  locator.registerLazySingleton<MovieDataSource>(
    () => MovieDataSourceImpl(locator()),
  );

  //Core
  locator.registerLazySingleton<ApiClient>(() => ApiClient(Client()));
}
