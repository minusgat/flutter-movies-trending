import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../commons/constants/size_constants.dart';
import '../../data/core/api_constants.dart';
import '../../domain/entity/movie_entity.dart';
import 'blur_image.dart';
import 'movie_card.dart';

typedef ListHandler(List list);
typedef IndexHandler(int index);

class CarouselController {
  ListHandler? addElements;
  ListHandler? rebootController;
  VoidCallback? clearElements;
  IndexHandler? jumpTo;

  void dispose() {
    addElements = null;
    clearElements = null;
    jumpTo = null;
    rebootController = null;
  }
}

typedef MoviesHandler(MovieEntity movie);

class AnimatedInfiniteCarousel extends StatefulWidget {
  final CarouselController? controller;
  final IndexHandler? onLastItemLoaded;
  final IndexHandler? onFirstItemLoaded;
  final IndexHandler? onCarouselIndexChange;
  final MoviesHandler? onCarouselItemChange;

  const AnimatedInfiniteCarousel({
    Key? key,
    this.controller,
    this.onLastItemLoaded,
    this.onCarouselIndexChange,
    this.onCarouselItemChange,
    this.onFirstItemLoaded,
  }) : super(key: key);

  @override
  _AnimatedInfiniteCarouselState createState() =>
      _AnimatedInfiniteCarouselState();
}

class _AnimatedInfiniteCarouselState extends State<AnimatedInfiniteCarousel> {
  late CarouselController _controller;
  late PageController _pageController;
  late MovieEntity _actualMovie;
  List _moviesList = [];
  int _carouselCursor = 1;

  @override
  void initState() {
    super.initState();
    _configCarouselController();
    _configPageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: buildLayout);
  }

  Widget buildMovieSlide(int builderIndex) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double itemIndex = 0;
          bool isActive = _carouselCursor == builderIndex;

          if (_pageController.position.haveDimensions) {
            itemIndex = builderIndex - (_pageController.page ?? 0);
            itemIndex = (itemIndex * (7 / 180)).clamp(-1, 1);
          }

          return AnimatedOpacity(
            duration: kDefaultAnimationDuration,
            opacity: isActive ? 1 : 0.2,
            child: Transform.rotate(
              angle: math.pi * itemIndex,
              child: MovieCard(
                isActive: isActive,
                movie: _moviesList.elementAt(builderIndex),
              ),
            ),
          );
        },
      );

  void _addElements(List list) {
    setState(() => _moviesList.addAll(list));
    print('${_moviesList.length}');
  }

  void _clearElements() {
    _pageController.jumpToPage(0);
    _moviesList.clear();
    setState(() {});
  }

  void _rebootCarousel(list) {
    _pageController.jumpToPage(5);
    _pageController.animateToPage(
      1,
      duration: Duration(seconds: 2),
      curve: Curves.easeOutSine,
    );
    _moviesList.clear();
    _moviesList.addAll(list);
    setState(() {});
  }

  void _jumpTo(int index) {}

  void _configCarouselController() {
    _controller = widget.controller ?? CarouselController();
    _controller.addElements = _addElements;
    _controller.clearElements = _clearElements;
    _controller.jumpTo = _jumpTo;
    _controller.rebootController = _rebootCarousel;
  }

  void _configPageController() {
    _pageController =
        PageController(initialPage: _carouselCursor, viewportFraction: 0.8)
          ..addListener(() {
            if (_moviesList.isNotEmpty) {
              _actualMovie = _moviesList.elementAt(_carouselCursor);

              if (widget.onCarouselIndexChange != null)
                widget.onCarouselIndexChange!(_carouselCursor);
              if (widget.onCarouselItemChange != null)
                widget.onCarouselItemChange!(_actualMovie);
            }

            //When the carousel it's positioned at the end we need to retrieve new data
            if (_pageController.position.maxScrollExtent ==
                    _pageController.position.pixels &&
                _carouselCursor > 0) {
              widget.onLastItemLoaded!(_carouselCursor);
            }
          });
  }

  void _handleOnPageChange(value) {
    setState(() => _carouselCursor = value);
  }

  Widget buildLayout(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: [
        buildBackground(),
        buildSlider(),
      ],
    );
  }

  Widget buildBackground() {
    return _moviesList.length > 0
        ? Positioned.fill(
            child: BlurredImage(
              fit: BoxFit.cover,
              url: ApiConstants.formatImageUrl(
                _moviesList.elementAt(_carouselCursor).posterPath,
              ),
            ),
          )
        : Container();
  }

  Widget buildSlider() {
    return PageView.builder(
      onPageChanged: _handleOnPageChange,
      controller: _pageController,
      itemCount: _moviesList.length,
      itemBuilder: (context, index) => buildMovieSlide(index),
    );
  }
}
