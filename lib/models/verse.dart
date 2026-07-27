class Verse {
  final int id;
  final String book;
  final int chapter;
  final int verse;
  final String text;

  Verse({
    required this.id,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory Verse.fromMap(Map<String, dynamic> map) {
    return Verse(
      id: map['id'] as int,
      book: map['book'] as String,
      chapter: map['chapter'] as int,
      verse: map['verse'] as int,
      text: map['text'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'text': text,
    };
  }

  @override
  String toString() {
    return '$book $chapter:$verse - $text';
  }
}
