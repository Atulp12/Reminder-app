import 'package:either_dart/either.dart';
import 'package:reminder_app/core/error/failure.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';

class GetReminders{
  final ReminderRepository _reminderRepository;

  GetReminders(this._reminderRepository);

  Future<Either<Failure,List<Reminder>>> call(){
    return _reminderRepository.getReminders();
  }
}