import 'package:flutter/material.dart';
import '../widgets/empty_data_widget.dart';
import '../../../../commons/extensions/l10n.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = context.l10n;
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmptyDataWidget(
          l10n: l10n,
        ),
      ],
    );
  }
}
