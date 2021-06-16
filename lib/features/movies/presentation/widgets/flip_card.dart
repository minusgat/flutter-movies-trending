import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../commons/constants/size_constants.dart';

typedef BoolHandler(bool active);

class FlipController {
  BoolHandler? isActive;

  void dispose() {
    isActive = null;
  }
}

class FlipCard extends StatefulWidget {
  final frontFace;
  final backDrop;
  final flipController;

  const FlipCard({Key? key, this.frontFace, this.backDrop, this.flipController})
      : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late FlipController _flipController;
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    configAnimationController();
    configFlipController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(pi * _animation.value),
      child: GestureDetector(
        onTap: handleCardTap,
        child: _animation.value <= 0.5
            ? widget.frontFace
            : Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi),
                child: widget.backDrop,
              ),
      ),
    );
  }

  void handleCardTap() {
    if (_animationStatus == AnimationStatus.dismissed)
      _controller.forward();
    else
      _controller.reverse();
  }

  void handleFlipStatus(bool isActive) {
    if (isActive)
      _controller.forward();
    else
      _controller.reverse();
  }

  void configAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  void configFlipController() {
    _flipController = widget.flipController ?? FlipController();
    _flipController.isActive = handleFlipStatus;
  }
}
