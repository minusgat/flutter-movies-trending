import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String message;
  final DateTime dateTime = DateTime.now();

  NotificationEntity(this.message);

  @override
  List<Object?> get props => [dateTime];
}
