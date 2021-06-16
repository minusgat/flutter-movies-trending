import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../commons/extensions/l10n.dart';

class BottomBarWidget extends StatefulWidget {
  final Function? onOptionTap;

  const BottomBarWidget({Key? key, this.onOptionTap}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      selectedIconTheme:
      Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
      onTap: handleOnOptionTap,
      currentIndex: selectedIndex,
      items: [
        bottomBarItem('assets/ic-home.svg', context.l10n!.home),
        bottomBarItem('assets/ic-discovery.svg', context.l10n!.discover),
        bottomBarItem('assets/ic-cog.svg', context.l10n!.settings),
      ],
    );
  }

  BottomNavigationBarItem bottomBarItem(String asset, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
      ),
      label: label,
    );
  }

  void handleOnOptionTap(int value) {
    setState(() => selectedIndex = value);
    if (widget.onOptionTap != null) widget.onOptionTap!(value);
  }
}