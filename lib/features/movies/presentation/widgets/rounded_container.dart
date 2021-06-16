import 'package:flutter/material.dart';
import '../../../../commons/constants/size_constants.dart';

class RoundedContainer extends StatelessWidget {
  final child;

  const RoundedContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: child,
    );
  }
}
