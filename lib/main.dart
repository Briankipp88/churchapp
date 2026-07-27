import 'package:flutter/material.dart';
import 'screens/lessons_screen.dart';
import 'screens/bible_screen.dart';
import 'screens/hymnal_screen.dart';

void main() {
  runApp(const SdaCompanionApp());
}

class SdaCompanionApp extends StatelessWidget {
  const SdaCompanionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDA Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const LessonsScreen(),
    const BibleScreen(),
    const HymnalScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDA Companion'),
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Lessons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bible',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Hymnal',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
