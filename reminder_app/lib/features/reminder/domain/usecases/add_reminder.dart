import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';

class AddReminder{
  final ReminderRepository _reminderRepository;

  AddReminder(this._reminderRepository);

  Future<void> call(Reminder reminder){
    return _reminderRepository.addReminder(reminder);
  }
}