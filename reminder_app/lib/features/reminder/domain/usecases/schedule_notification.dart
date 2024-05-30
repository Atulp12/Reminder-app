import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/notification_repository.dart';

class ScheduleNotification{
  final NotificationRepository _notificationRepository;

  ScheduleNotification(this._notificationRepository);

  Future<void> call(Reminder reminder) async {
    return _notificationRepository.scheduleNotification(reminder);
  }
}