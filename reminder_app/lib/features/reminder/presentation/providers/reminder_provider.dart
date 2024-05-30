import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:reminder_app/features/reminder/data/models/reminder_model.dart';
import 'package:reminder_app/features/reminder/data/repositories/notification_repository_impl.dart';
import 'package:reminder_app/features/reminder/data/repositories/reminder_repository_impl.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/notification_repository.dart';
import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';
import 'package:reminder_app/features/reminder/domain/usecases/add_reminder.dart';
import 'package:reminder_app/features/reminder/domain/usecases/delete_reminder.dart';
import 'package:reminder_app/features/reminder/domain/usecases/get_reminders.dart';
import 'package:reminder_app/features/reminder/domain/usecases/schedule_notification.dart';
import 'package:reminder_app/features/reminder/domain/usecases/update_reminders.dart';

final reminderLocalDataSourceProvider =
    Provider<ReminderLocalDataSource>((ref) {
  final Box<ReminderModel> reminders = Hive.box('reminders');
  return ReminderLocalDataSource(reminders);
});

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  final localDataSource = ref.read(reminderLocalDataSourceProvider);
  return ReminderRepositoryImpl(localDataSource);
});

final getRemindersProvider = Provider<GetReminders>((ref) {
  final reminderRpository = ref.read(reminderRepositoryProvider);
  return GetReminders(reminderRpository);
});

final addReminderProvider = Provider<AddReminder>((ref) {
  final reminderRpository = ref.read(reminderRepositoryProvider);
  return AddReminder(reminderRpository);
});

final updateReminderProvider = Provider<UpdateReminder>((ref) {
  final reminderRpository = ref.read(reminderRepositoryProvider);
  return UpdateReminder(reminderRpository);
});

final deleteReminderProvider = Provider<DeleteReminder>((ref) {
  final reminderRpository = ref.read(reminderRepositoryProvider);
  return DeleteReminder(reminderRpository);
});

final flutterLocalNotificationsPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(ref.read(flutterLocalNotificationsPluginProvider));
});

final scheduleNotificationProvider = Provider<ScheduleNotification>((ref) {
  return ScheduleNotification(ref.read(notificationRepositoryProvider));
});

final reminderListNotifierProvider =
    StateNotifierProvider<ReminderNotifier, List<Reminder>>((ref) {
  final getReminder = ref.read(getRemindersProvider);
  final addReminder = ref.read(addReminderProvider);
  final updateReminder = ref.read(updateReminderProvider);
  final deleteReminder = ref.read(deleteReminderProvider);
  final scheduleNotification = ref.read(scheduleNotificationProvider);

  return ReminderNotifier(
    getReminder,
    addReminder,
    updateReminder,
    deleteReminder,
    scheduleNotification
  );
});

class ReminderNotifier extends StateNotifier<List<Reminder>> {
  final GetReminders _reminders;
  final AddReminder _addReminder;
  final UpdateReminder _updateReminder;
  final DeleteReminder _deleteReminder;
  final ScheduleNotification notificationService;

  ReminderNotifier(
    this._reminders,
    this._addReminder,
    this._updateReminder,
    this._deleteReminder,
    this.notificationService
  ) : super([]);

  Future<void> loadReminders() async {
    final reminder = await _reminders();
    reminder.fold((error) => [], (reminder) => state = reminder);

  }

  Future<void> addReminder(Reminder reminder) async {
    await _addReminder(reminder);
  }

  Future<void> updateReminder(Reminder updateReminder, int i) async {
    await _updateReminder(updateReminder, i);
  }

  Future<void> deleteReminder(int i) async {
    await _deleteReminder(i);
  }

  Future<void> notificationReminder(Reminder reminder) async{
    await notificationService(reminder);
  }
}
