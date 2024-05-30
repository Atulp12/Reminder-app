import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';

class DeleteReminder{
  final ReminderRepository _reminderRepository;

  DeleteReminder(this._reminderRepository);

  Future<void> call(int index){
    return _reminderRepository.deleteReminder(index);
  }
}