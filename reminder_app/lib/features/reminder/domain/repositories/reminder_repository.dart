import 'package:either_dart/either.dart';
import 'package:reminder_app/core/error/failure.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';

abstract interface class ReminderRepository{
  Future<Either<Failure,List<Reminder>>> getReminders();
  Future<void> addReminder(Reminder reminder);
  Future<void> updateReminder(Reminder updateReminder,int index);
  Future<void> deleteReminder(int index);
}