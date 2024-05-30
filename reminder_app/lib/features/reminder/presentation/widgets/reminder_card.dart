import 'package:flutter/material.dart';
import 'package:reminder_app/core/theme/app_pallete.dart';

class ReminderCard extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ReminderCard({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.onEdit,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 120,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                
                radius: 22,
                child: Text(
                  title[0],
                  style:  Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      desc,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      time,
                      style:const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppPallete.gradient1),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onEdit,
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
