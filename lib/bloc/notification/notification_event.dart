import 'package:amiriy/data/models/notification_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationCallEvent extends NotificationEvent {
  @override
  List<Object?> get props => [];
}

class NotificationInsertEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  NotificationInsertEvent({required this.notificationModel});

  @override
  List<Object?> get props => [notificationModel];
}

class NotificationDeleteEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  NotificationDeleteEvent({required this.notificationModel});

  @override
  List<Object?> get props => [notificationModel];
}
class MarkAsReadEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  MarkAsReadEvent({required this.notificationModel});

  @override
  List<Object?> get props => [notificationModel];
}

class MarkAsUnreadEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  MarkAsUnreadEvent({required this.notificationModel});

  @override
  List<Object?> get props => [notificationModel];
}

class MarkAllAsReadEvent extends NotificationEvent {
  @override
  List<Object?> get props => [];
}
