import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/constants/size_constants.dart';
import '../bloc/loader_bloc/loader_cubit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderCubit, bool>(
      builder: (context, state) {
        return PositionedDirectional(
          end: 0,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultBorderRadius),
            child: state
                ? Container(
                    width: kDefaultBorderRadius,
                    height: kDefaultBorderRadius,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
