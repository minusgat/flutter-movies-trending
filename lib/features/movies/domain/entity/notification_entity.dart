import 'package:equatable/equatable.dart';
import 'package:flutter_movies_trending/commons/error/app_error.dart';

class NotificationEntity extends Equatable {
  final String message;
  final DateTime dateTime = DateTime.now();

  NotificationEntity({this.message = ''});

  @override
  List<Object?> get props => [dateTime];
}

class NotificationErrorEntity extends NotificationEntity {
  final AppErrorType appErrorType;

  NotificationErrorEntity({this.appErrorType = AppErrorType.unknown});

}
