import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';

abstract interface class NotificationRepository{
   Future<void> scheduleNotification(Reminder reminder);
}