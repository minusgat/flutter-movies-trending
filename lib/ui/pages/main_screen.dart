import 'package:flutter/material.dart';
import 'package:flutter_movies_trending/l10n/l10n.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;

    return Scaffold(
      body: Container(
        child: Center(
          child: Text(l10n.home),
        ),
      ),
    );
  }
}
