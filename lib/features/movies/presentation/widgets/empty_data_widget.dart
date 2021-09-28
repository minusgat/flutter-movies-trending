import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'levitation_animated_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  final l10n;

  const EmptyDataWidget({Key? key, required this.l10n}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: LevitationAnimatedWidget(
              child: SvgPicture.asset(
                'assets/ic-game.svg',
                height: 124,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Text(
            l10n.emptyResponse,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
