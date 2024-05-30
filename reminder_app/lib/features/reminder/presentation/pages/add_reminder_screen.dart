import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_app/core/utils/utils.dart';
import 'package:reminder_app/features/reminder/domain/entities/reminder.dart';
import 'package:reminder_app/features/reminder/presentation/providers/reminder_provider.dart';
import 'package:reminder_app/features/reminder/presentation/widgets/custom_button.dart';
import 'package:reminder_app/features/reminder/presentation/widgets/text_field.dart';

class AddReminderScreen extends ConsumerStatefulWidget {
  final Reminder? reminder;
  final int? index;
  const AddReminderScreen({super.key, this.reminder, this.index});

  @override
  ConsumerState<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    if (widget.reminder != null) {
      titleController.text = widget.reminder!.title;
      descriptionController.text = widget.reminder!.description;
      timeController.text = widget.reminder!.time;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void timePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String formattedHour = pickedTime.hourOfPeriod.toString().padLeft(2, '0');
      String formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
      String formattedTime =
          "$formattedHour:$formattedMinute ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
      setState(() {
        timeController.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder != null ? "Edit Reminder" : "Add Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: titleController,
              hintText: 'Enter title',
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: descriptionController,
              hintText: 'Enter Description',
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: timeController,
              hintText: 'Time',
              onTap: timePicker,
              keyBoardType: TextInputType.none,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              buttonText:
                  widget.reminder != null ? "Update Reminder" : "Add Reminder",
              onPressed: () {
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    timeController.text.isEmpty) {
                  showSnackBar(
                    "Please fill all the Fields!!",
                  );
                } else {
                  final newReminder = Reminder(
                    title: titleController.text,
                    description: descriptionController.text,
                    time: timeController.text,
                    priority: 0,
                  );
                  if (widget.reminder != null) {
                    ref
                        .read(reminderListNotifierProvider.notifier)
                        .updateReminder(newReminder, widget.index!);
                  } else {
                    ref
                        .read(reminderListNotifierProvider.notifier)
                        .addReminder(newReminder);
                  }
                  ref
                      .read(reminderListNotifierProvider.notifier)
                      .notificationReminder(newReminder);
                  ref
                      .read(reminderListNotifierProvider.notifier)
                      .loadReminders();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
