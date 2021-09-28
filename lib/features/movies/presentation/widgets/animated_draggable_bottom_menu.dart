import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/constants/size_constants.dart';
import '../bloc/language_bloc/language_cubit.dart';
import 'package:flutter_svg/svg.dart';

import 'animated_arrow.dart';
import 'language_trigger.dart';

class AnimatedBottomMenu extends StatefulWidget {
  final double min;
  final double max;
  final child;
  final l10n;

  const AnimatedBottomMenu({
    Key? key,
    this.min: 0.2,
    this.max: 0.2,
    this.child,
    this.l10n,
  }) : super(key: key);

  @override
  _AnimatedBottomMenuState createState() => _AnimatedBottomMenuState();
}

class _AnimatedBottomMenuState extends State<AnimatedBottomMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Tween<Offset> _tween;

  @override
  void initState() {
    super.initState();
    configController();
  }

  void _toggle() {
    if (_controller.isDismissed)
      _controller.forward();
    else if (_controller.isCompleted) _controller.reverse();
  }

  void configController() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _tween = Tween(
      begin: Offset(0, .14),
      end: Offset(0, 0),
    );
    _animation = _tween.animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageManagerCubit, LanguageManagerState>(
      listener: (context, state) {
        _toggle();
      },
      child: SlideTransition(
        position: _animation,
        child: _sheet(),
      ),
    );
  }

  Widget _sheet() {
    return DraggableScrollableSheet(
      initialChildSize: widget.min,
      minChildSize: widget.min,
      maxChildSize: widget.max,
      builder: menuBuilder,
    );
  }

  Widget menuBuilder(BuildContext context, ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultBorderRadius),
          topRight: Radius.circular(kDefaultBorderRadius),
        ),
        boxShadow: [
          kDefaultShadow,
        ],
      ),
      child: SingleChildScrollView(
        child: buildMenuContainer(),
      ),
    );
  }

  Widget buildMenuContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          right: kDefaultBorderRadius,
          left: kDefaultBorderRadius,
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedArrow(
              child: SvgPicture.asset('assets/ic-arrow-up.svg'),
              onTap: _toggle,
            ),
            Divider(height: 24),
            Text(widget.l10n.pickALanguage),
            LanguageTrigger(l10n: widget.l10n),
          ],
        ),
      ),
    );
  }
}
