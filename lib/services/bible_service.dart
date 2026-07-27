import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/verse.dart';

class BibleService {
  static final BibleService _instance = BibleService._internal();
  Database? _database;

  factory BibleService() {
    return _instance;
  }

  BibleService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kjv.sqlite');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Note: The kjv.sqlite database should be pre-populated
    // This is a placeholder for the database schema
    await db.execute('''
      CREATE TABLE IF NOT EXISTS verses (
        id INTEGER PRIMARY KEY,
        book TEXT NOT NULL,
        chapter INTEGER NOT NULL,
        verse INTEGER NOT NULL,
        text TEXT NOT NULL
      )
    ''');
  }

  Future<List<Verse>> getVersesForChapter(String book, int chapter) async {
    final db = await database;
    final maps = await db.query(
      'verses',
      where: 'book = ? AND chapter = ?',
      whereArgs: [book, chapter],
      orderBy: 'verse ASC',
    );

    return List.generate(maps.length, (i) {
      return Verse.fromMap(maps[i]);
    });
  }

  Future<Verse?> getVerse(String book, int chapter, int verse) async {
    final db = await database;
    final maps = await db.query(
      'verses',
      where: 'book = ? AND chapter = ? AND verse = ?',
      whereArgs: [book, chapter, verse],
    );

    if (maps.isNotEmpty) {
      return Verse.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Verse>> searchVerses(String query) async {
    final db = await database;
    final maps = await db.query(
      'verses',
      where: 'text LIKE ?',
      whereArgs: ['%$query%'],
      limit: 50,
    );

    return List.generate(maps.length, (i) {
      return Verse.fromMap(maps[i]);
    });
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
