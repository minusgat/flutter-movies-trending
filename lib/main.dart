import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/movies/domain/use_case/get_movie_search.dart';
import 'features/movies/presentation/bloc/notification_bloc/notification_cubit.dart';
import 'package:http/http.dart';

import 'commons/extensions/l10n.dart';
import 'commons/themes/app_theme.dart';
import 'features/movies/data/core/api_client.dart';
import 'features/movies/data/data_source/movie_data_source.dart';
import 'features/movies/data/repository/movies_repository_impl.dart';
import 'features/movies/domain/repository/language_repository.dart';
import 'features/movies/domain/use_case/get_trending_movies.dart';
import 'features/movies/presentation/bloc/language_bloc/language_cubit.dart';
import 'features/movies/presentation/bloc/loader_bloc/loader_cubit.dart';
import 'features/movies/presentation/bloc/movies_trending_bloc/movies_trending_cubit.dart';
import 'features/movies/presentation/pages/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final moviesList;

  const MyApp({Key? key, this.moviesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient(Client());

    MovieDataSource movieDataSource = MovieDataSourceImpl(apiClient);
    MovieRepository movieRepository = MovieRepositoryImpl(movieDataSource);

    GetTrending getTrending = GetTrending(movieRepository);
    GetMovieSearch getMovieSearch = GetMovieSearch(movieRepository);

    return buildMultiBlocProvider(getTrending, getMovieSearch);
  }

  MultiBlocProvider buildMultiBlocProvider(
      GetTrending getTrending, GetMovieSearch getMovieSearch) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoaderCubit(),
        ),
        BlocProvider(
          create: (_) => NotificationCubit(),
        ),
        BlocProvider(
          create: (_) => LanguageManagerCubit(
            loaderCubit: BlocProvider.of<LoaderCubit>(_),
          ),
        ),
        BlocProvider(
          create: (_) => MoviesCubit(
            movieSearch: getMovieSearch,
            getTrending: getTrending,
            notificationCubit: BlocProvider.of<NotificationCubit>(_),
            loaderCubit: BlocProvider.of<LoaderCubit>(_),
            languagesCubit: BlocProvider.of<LanguageManagerCubit>(_),
          ),
        ),
      ],
      child: BlocBuilder<LanguageManagerCubit, LanguageManagerState>(
        builder: (context, languageState) {
          return buildMaterialApp(languageState);
        },
      ),
    );
  }

  MaterialApp buildMaterialApp(LanguageManagerState languageState) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale.fromSubtags(languageCode: languageState.language.code),
      title: 'Titulo',
      theme: AppTheme.darkTheme,
      home: MainScreen(),
    );
  }
}
