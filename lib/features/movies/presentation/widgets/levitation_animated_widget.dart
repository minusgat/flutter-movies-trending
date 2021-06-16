import 'package:flutter/material.dart';

class LevitationAnimatedWidget extends StatefulWidget {
  final child;
  final bool isActive;
  final duration;
  final offset;
  final repeat;

  const LevitationAnimatedWidget(
      {Key? key,
      this.child,
      this.isActive = false,
      this.duration = 2000,
      this.offset = -0.035,
      this.repeat = true})
      : super(key: key);

  @override
  _LevitationAnimatedWidgetState createState() =>
      _LevitationAnimatedWidgetState();
}

class _LevitationAnimatedWidgetState extends State<LevitationAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat(reverse: widget.repeat);

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, widget.offset),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isActive
        ? SlideTransition(position: _offsetAnimation, child: widget.child)
        : widget.child;
  }
}
