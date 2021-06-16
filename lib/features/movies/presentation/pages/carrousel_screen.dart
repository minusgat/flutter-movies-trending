import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/language_bloc/language_cubit.dart';
import '../bloc/movies_trending_bloc/movies_trending_cubit.dart';
import '../widgets/animated_infinite_carousel.dart';

class CarouselScreen extends StatefulWidget {
  final MoviesCubit moviesTrendingCubit;

  const CarouselScreen({
    Key? key,
    required this.moviesTrendingCubit,
  }) : super(key: key);

  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late CarouselController carouselController;

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageManagerCubit, LanguageManagerState>(
      listener: languageListener,
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: builder,
      ),
    );
  }

  Widget builder(BuildContext context, state) {
    if (state is MoviesInitial) {
      widget.moviesTrendingCubit.loadTrending();
    }

    if (state is MoviesLoaded) {
      carouselController.addElements!(state.movies);
    }

    if (state is MoviesTrendingTranslatedLoaded) {
      carouselController.rebootController!(state.movies);
    }

    return AnimatedInfiniteCarousel(
      controller: carouselController,
      onLastItemLoaded: onCarouselLastItemLoaded,
    );
  }

  void onCarouselLastItemLoaded(int index) {
    widget.moviesTrendingCubit.loadTrending(cursorIndex: index);
  }

  void languageListener(BuildContext context, state) {
    widget.moviesTrendingCubit.loadTrendingTranslation();
  }
}
