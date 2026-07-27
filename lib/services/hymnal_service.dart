import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/hymn.dart';

class HymnalService {
  static final HymnalService _instance = HymnalService._internal();
  List<Hymn>? _hymns;

  factory HymnalService() {
    return _instance;
  }

  HymnalService._internal();

  Future<List<Hymn>> loadHymns() async {
    if (_hymns != null) return _hymns!;

    try {
      final jsonString = await rootBundle.loadString('assets/hymnal/sda_hymns.json');
      final jsonData = json.decode(jsonString) as List;
      _hymns = jsonData.map((hymn) => Hymn.fromJson(hymn as Map<String, dynamic>)).toList();
      return _hymns!;
    } catch (e) {
      print('Error loading hymns: $e');
      return [];
    }
  }

  Future<Hymn?> getHymnByNumber(String number) async {
    final hymns = await loadHymns();
    try {
      return hymns.firstWhere((h) => h.number == number);
    } catch (e) {
      return null;
    }
  }

  Future<List<Hymn>> searchHymns(String query) async {
    final hymns = await loadHymns();
    final lowerQuery = query.toLowerCase();

    return hymns
        .where((hymn) =>
            hymn.title.toLowerCase().contains(lowerQuery) ||
            hymn.author.toLowerCase().contains(lowerQuery) ||
            hymn.lyrics.toLowerCase().contains(lowerQuery))
        .toList();
  }

  Future<List<Hymn>> getAllHymns() async {
    return await loadHymns();
  }
}
