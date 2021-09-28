import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../../commons/constants/color_constants.dart';
import '../../../../commons/constants/size_constants.dart';
import '../../data/core/api_constants.dart';
import '../../data/model/movie_model.dart';
import '../bloc/language_bloc/language_cubit.dart';
import 'blur_image.dart';
import 'flip_card.dart';
import 'levitation_animated_widget.dart';
import 'rounded_container.dart';
import 'rounded_image.dart';

class MovieCard extends StatelessWidget {
  final MovieModel? movie;
  final isActive;

  const MovieCard({Key? key, this.movie, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: buildMovieCard(context),
    );
  }

  Widget buildMovieCard(BuildContext context) {
    return BlocBuilder<LanguageManagerCubit, LanguageManagerState>(
      builder: (context, state) {
        return Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.2,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultBorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie?.title ?? 'Sin titulo',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          buildMovieReleaseDate(movie, state),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${movie?.voteAverage ?? 5}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            RatingBar.builder(
                              itemSize: 20.0,
                              initialRating: (movie?.voteAverageFormatted ?? 5),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: ratingColor,
                                size: 2.0,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Column(
                  children: [
                    Expanded(
                      child: FlipCard(
                        frontFace: LevitationAnimatedWidget(
                          isActive: isActive,
                          child: RoundedImage(
                            url: ApiConstants.formatImageUrl(movie?.posterPath),
                          ),
                        ),
                        backDrop: RoundedContainer(
                          child: Container(
                            color: Colors.black,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                BlurredImage(
                                  fit: BoxFit.cover,
                                  url: ApiConstants.formatImageUrl(
                                    movie?.backdropPath,
                                  ),
                                ),
                                Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  verticalDirection: VerticalDirection.down,
                                  children: [
                                    Flexible(
                                      child: RoundedImage(
                                        fit: BoxFit.cover,
                                        url: ApiConstants.formatImageUrl(
                                          movie?.backdropPath,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              kDefaultBorderRadius),
                                          child: Text(movie?.overview ?? ''),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String buildMovieReleaseDate(
      MovieModel? movie, LanguageManagerState languageState) {
    String date = movie?.releaseDate ?? 'Sin fecha';
    DateTime? now = DateTime.tryParse(date);
    String formattedDate =
        DateFormat.yMMMMd(languageState.language.code).format(now!);
    return formattedDate;
  }
}
