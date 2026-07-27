class Hymn {
  final int id;
  final String number;
  final String title;
  final String author;
  final String lyrics;
  final List<String> stanzas;

  Hymn({
    required this.id,
    required this.number,
    required this.title,
    required this.author,
    required this.lyrics,
    required this.stanzas,
  });

  factory Hymn.fromJson(Map<String, dynamic> json) {
    return Hymn(
      id: json['id'] as int? ?? 0,
      number: json['number'] as String? ?? '',
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      lyrics: json['lyrics'] as String? ?? '',
      stanzas: List<String>.from(json['stanzas'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'author': author,
      'lyrics': lyrics,
      'stanzas': stanzas,
    };
  }

  @override
  String toString() {
    return '$number - $title by $author';
  }
}
