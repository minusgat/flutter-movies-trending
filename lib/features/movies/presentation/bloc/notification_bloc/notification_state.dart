part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationLoaded extends NotificationState {
  final NotificationEntity notificationEntity;

  NotificationLoaded(this.notificationEntity);
}
