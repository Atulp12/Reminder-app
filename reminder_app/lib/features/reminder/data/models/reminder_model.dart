import 'package:hive/hive.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String time;

  @HiveField(3)
  final int priority;

  ReminderModel(
      {required this.title,
      required this.description,
      required this.time,
      required this.priority});

  factory ReminderModel.fromEntity(Reminder reminder) => ReminderModel(
      title: reminder.title,
      description: reminder.description,
      time: reminder.time,
      priority: reminder.priority);

  Reminder toEntity() => Reminder(
      title: title, description: description, time: time, priority: priority);
}
