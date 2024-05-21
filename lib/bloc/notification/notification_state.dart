import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/notification_model.dart';

class NotificationState {
  final String errorText;
  final String statusMessage;
  final FormStatus formsStatus;
  final List<NotificationModel> notificationModel;

  NotificationState({
    required this.formsStatus,
    required this.errorText,
    required this.statusMessage,
    required this.notificationModel,
  });

  NotificationState copyWith({
    String? errorText,
    FormStatus? formsStatus,
    String? statusMessage,
    List<NotificationModel>? notificationModel,
  }) {
    return NotificationState(
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      notificationModel: notificationModel ?? this.notificationModel,
      formsStatus: formsStatus ?? this.formsStatus,
    );
  }
}
