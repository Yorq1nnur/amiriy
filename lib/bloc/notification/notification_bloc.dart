import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/notification/notification_event.dart';
import 'package:amiriy/bloc/notification/notification_state.dart';
import 'package:amiriy/data/local/local_database.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/models/notification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(
          NotificationState(
            errorText: '',
            statusMessage: '',
            notificationModel: [],
            formsStatus: FormStatus.pure,
          ),
        ) {
    on<NotificationCallEvent>(_callNotifications);
    on<NotificationInsertEvent>(_insertNotifications);
    on<NotificationDeleteEvent>(_deleteNotifications);
    on<MarkAsReadEvent>(_markAsRead);
    on<MarkAsUnreadEvent>(_markAsUnread);
    on<MarkAllAsReadEvent>(_markAllAsRead);
  }

  Future<void> _callNotifications(NotificationCallEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await LocalDatabase.getAllNotification();

    emit(state.copyWith(
        notificationModel: networkResponse.data,
        formsStatus: FormStatus.success));
  }

  Future<void> _insertNotifications(NotificationInsertEvent event, emit) async {
    await LocalDatabase.insertNotification(event.notificationModel);

    add(NotificationCallEvent());
  }

  Future<void> _deleteNotifications(NotificationDeleteEvent event, emit) async {
    await LocalDatabase.deleteNotification(event.notificationModel.id ?? 0);

    add(NotificationCallEvent());
  }


  Future<void> _markAsRead(MarkAsReadEvent event, emit) async {
    await LocalDatabase.markAsRead(event.notificationModel.id ?? 0);
    add(NotificationCallEvent());
  }

  Future<void> _markAsUnread(MarkAsUnreadEvent event, emit) async {
    await LocalDatabase.markAsUnread(event.notificationModel.id ?? 0);
    add(NotificationCallEvent());
  }

  Future<void> _markAllAsRead(MarkAllAsReadEvent event, emit) async {
    List<NotificationModel> unreadNotifications = await LocalDatabase.getUnreadNotifications();
    for (var notification in unreadNotifications) {
      await LocalDatabase.markAsRead(notification.id ?? 0);
    }
    add(NotificationCallEvent());
  }
}
