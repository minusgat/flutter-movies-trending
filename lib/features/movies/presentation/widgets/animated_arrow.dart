import 'package:flutter/material.dart';
import '../../../../commons/constants/size_constants.dart';

class AnimatedArrow extends StatefulWidget {
  final child;
  final Function(double progress)? animationListener;
  final Function() onTap;

  const AnimatedArrow({
    Key? key,
    this.child,
    this.animationListener,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedArrowState createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> turnsTween = Tween<double>(begin: 0, end: 0.5);
  bool _first = true;

  void configController() {
    _controller = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration,
    );
    if (widget.animationListener != null)
      _controller.addListener(() {
        widget.animationListener!(_controller.value);
      });
  }

  @override
  void initState() {
    configController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: turnsTween.animate(_controller),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: widget.child,
        ),
        onTap: handleArrowTap,
      ),
    );
  }

  void handleArrowTap() {
    if (_first) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _first = !_first;

    widget.onTap();
  }
}
