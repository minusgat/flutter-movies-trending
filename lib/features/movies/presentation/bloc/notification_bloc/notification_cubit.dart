import 'package:bloc/bloc.dart';
import '../../../domain/entity/notification_entity.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void show(String message) =>
      emit(NotificationLoaded(NotificationEntity(message)));
}
