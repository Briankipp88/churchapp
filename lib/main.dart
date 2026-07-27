import 'package:flutter/material.dart';

void main() {
  runApp(const SDACompanionApp());
}

class SDACompanionApp extends StatelessWidget {
  const SDACompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDA Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Classic Navy Theme
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // The 3 Core Modules inside One App
  final List<Widget> _screens = const [
    LessonsScreen(),
    BibleScreen(),
    HymnalScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Lessons',
          ),
          NavigationDestination(
            icon: Icon(Icons.import_contacts_outlined),
            selectedIcon: Icon(Icons.import_contacts),
            label: 'Bible',
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note_outlined),
            selectedIcon: Icon(Icons.music_note),
            label: 'Hymnal',
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// MODULE 1: Sabbath School Lessons Tab
// -------------------------------------------------------------------
class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sabbath School Lesson')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              title: Text('Lesson 1: The Gospel Prior to the Cross'),
              subtitle: Text('Memory Text: John 3:16'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Lesson 2: God\'s Covenant with Us'),
              subtitle: Text('Memory Text: Genesis 17:7'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// MODULE 2: Holy Bible Tab
// -------------------------------------------------------------------
class BibleScreen extends StatelessWidget {
  const BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holy Bible (KJV)'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 31,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Verse ${index + 1}: Genesis chapter text goes here...'),
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------------
// MODULE 3: SDA Hymnal Tab
// -------------------------------------------------------------------
class HymnalScreen extends StatelessWidget {
  const HymnalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDA Hymnal'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Text('#1', style: TextStyle(fontWeight: FontWeight.bold)),
            title: Text('Praise to the Lord'),
            subtitle: Text('Worship & Praise'),
          ),
          ListTile(
            leading: Text('#2', style: TextStyle(fontWeight: FontWeight.bold)),
            title: Text('All Creatures of Our God and King'),
            subtitle: Text('Creation'),
          ),
        ],
      ),
    );
  }
}
