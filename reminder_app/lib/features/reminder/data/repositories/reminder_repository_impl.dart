import 'package:either_dart/either.dart';
import 'package:reminder_app/core/error/failure.dart';
import 'package:reminder_app/features/reminder/data/datasources/reminder_local_datasource.dart';
import 'package:reminder_app/features/reminder/data/models/reminder_model.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource _localDataSource;

  ReminderRepositoryImpl(this._localDataSource);

  @override
  Future<void> addReminder(Reminder reminder) async {
    final reminderModel = ReminderModel.fromEntity(reminder);
    _localDataSource.addReminder(reminderModel);
  }

  @override
  Future<void> deleteReminder(int index) async {
    _localDataSource.deleteReminder(index);
  }

  @override
  Future<Either<Failure, List<Reminder>>> getReminders() async {
    try {
      final reminderModels = _localDataSource.getReminders();
      List<Reminder> res = reminderModels.map((e) => e.toEntity()).toList();
      return Right(res);
    } catch (e) {
      return Left(
        SomeError(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> updateReminder(Reminder updateReminder, int index) async {
    final reminderModel = ReminderModel.fromEntity(updateReminder);
    _localDataSource.updateReminder(reminderModel, index);
  }
}
