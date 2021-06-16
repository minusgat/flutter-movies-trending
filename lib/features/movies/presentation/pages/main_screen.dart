import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies_trending_bloc/movies_trending_cubit.dart';
import 'empty_screen.dart';
import '../widgets/animated_draggable_bottom_menu.dart';
import '../widgets/loader.dart';
import '../widgets/notification_wiget.dart';
import '../../../../commons/extensions/l10n.dart';
import 'carrousel_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoviesCubit moviesTrendingCubit = BlocProvider.of<MoviesCubit>(context);

    var l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            NotificationWidget(),
            EmptyScreen(),
            CarouselScreen(
              moviesTrendingCubit: moviesTrendingCubit,
            ),
            AnimatedBottomMenu(
              l10n: l10n,
            ),
            Loader(),
          ],
        ),
      ),
    );
  }
}
