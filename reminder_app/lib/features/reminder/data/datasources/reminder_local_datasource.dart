import 'package:hive/hive.dart';
import 'package:reminder_app/features/reminder/data/models/reminder_model.dart';

class ReminderLocalDataSource{
  final Box<ReminderModel> reminderBox;

  ReminderLocalDataSource(this.reminderBox);

  List<ReminderModel> getReminders(){
    return reminderBox.values.toList();
  }

  void addReminder(ReminderModel reminder){
    reminderBox.add(reminder);
  }

  void updateReminder(ReminderModel updateReminder,int index){
    reminderBox.putAt(index, updateReminder);
  }

  void deleteReminder(int index){
    reminderBox.deleteAt(index);
  }
}