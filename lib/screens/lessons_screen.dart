import 'package:flutter/material.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sabbath School Lessons',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Current Quarter'),
                subtitle: const Text('Load lessons from assets'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lessons loading...')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lesson Features:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Offline Access'),
              subtitle: Text('Pre-cached quarterly lessons'),
            ),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Bible Integration'),
              subtitle: Text('Link to offline Bible verses'),
            ),
            const ListTile(
              leading: Icon(Icons.check),
              title: Text('Hymnal Integration'),
              subtitle: Text('Access related hymns'),
            ),
          ],
        ),
      ),
    );
  }
}
