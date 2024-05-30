import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';

class UpdateReminder{
  final ReminderRepository _reminderRepository;

  UpdateReminder(this._reminderRepository);

  Future<void> call(Reminder updateReminder, int index){
    return _reminderRepository.updateReminder(updateReminder, index);
  }
}