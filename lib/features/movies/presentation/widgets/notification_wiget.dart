import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/constants/size_constants.dart';
import '../bloc/notification_bloc/notification_cubit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum NotificationStates { success, warning, error, primary }

class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (BuildContext context, state) {

        if (state is NotificationLoaded)
          showNotification(
            context,
            state.notificationEntity.message,
            false,
          );
        if (state is NotificationError)
          showNotification(
            context,
            '${state.notificationErrorEntity.appErrorType}',
            true,
          );
      },
      child: Container(),
    );
  }

  void showNotification(BuildContext context, String message, bool isError) {
    showToastWidget(buildNotificationContainer(context, message, isError),
        context: context,
        isIgnoring: false,
        duration: Duration(seconds: 2),
        curve: Curves.easeOutSine,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.fadeScale,
        reverseAnimation: StyledToastAnimation.fadeScale);
  }

  Container buildNotificationContainer(
    BuildContext context,
    String message,
    bool isError,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 18.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
        color: isError ? Colors.red : Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => ToastManager().dismissAll(showAnim: true),
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
