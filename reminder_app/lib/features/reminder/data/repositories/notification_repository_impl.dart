// ignore_for_file: deprecated_member_use

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/notification_repository.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationRepositoryImpl implements NotificationRepository{

   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationRepositoryImpl(this._flutterLocalNotificationsPlugin) {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),

    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }
  @override
  Future<void> scheduleNotification(Reminder reminder) async{
    final scheduledDate = _parseTime(reminder.time);

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );



    const notificationDetails = NotificationDetails(
      android: androidDetails,

    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.hashCode,
      reminder.title,
      reminder.description,
      scheduledDate.add(const Duration(seconds: 5)),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  tz.TZDateTime _parseTime(String time) {
    final now = DateTime.now();
    final timeParts = time.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);

    final int minute = int.parse(hourMinute[1]);


    if (timeParts[1]== 'PM' && hour != 12) {
      hour += 12;
    } else if (timeParts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

  final scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    return tz.TZDateTime.from(scheduledDate, tz.local);
  }




}