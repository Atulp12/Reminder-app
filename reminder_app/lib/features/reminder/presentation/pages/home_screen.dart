import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_app/features/reminder/presentation/pages/add_reminder_screen.dart';
import 'package:reminder_app/features/reminder/presentation/providers/reminder_provider.dart';
import 'package:reminder_app/features/reminder/presentation/widgets/reminder_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(reminderListNotifierProvider.notifier).loadReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reminderList = ref.watch(reminderListNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reminder",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: reminderList.isEmpty
          ? const Center(
              child: Text("No Reminders!! Please add reminders."),
            )
          : SizedBox(
              height: double.maxFinite,
              child: ListView.builder(
                  itemCount: reminderList.length,
                  itemBuilder: (context, i) {
                    return ReminderCard(
                      title: reminderList[i].title,
                      desc: reminderList[i].description,
                      time: reminderList[i].time,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReminderScreen(
                              reminder: reminderList[i],
                              index: i,
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        ref
                            .read(reminderListNotifierProvider.notifier)
                            .deleteReminder(i);
                        ref
                            .read(reminderListNotifierProvider.notifier)
                            .loadReminders();
                      },
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReminderScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
