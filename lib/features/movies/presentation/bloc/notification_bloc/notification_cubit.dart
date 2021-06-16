import 'package:bloc/bloc.dart';
import 'package:flutter_movies_trending/commons/error/app_error.dart';
import '../../../domain/entity/notification_entity.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void show(String message) =>
      emit(NotificationLoaded(NotificationEntity(message: message)));

  void showError(AppErrorType appError) =>
      emit(NotificationError(NotificationErrorEntity(appErrorType: appError)));
}
