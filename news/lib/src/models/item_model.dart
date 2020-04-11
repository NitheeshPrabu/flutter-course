import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDb(Map<String, dynamic> parsedRecord)
      : id = parsedRecord['id'],
        deleted = parsedRecord['deleted'] == 1,
        type = parsedRecord['type'],
        by = parsedRecord['by'],
        time = parsedRecord['time'],
        text = parsedRecord['text'],
        dead = parsedRecord['dead'] == 1,
        parent = parsedRecord['parent'],
        kids = jsonDecode(parsedRecord['kids']),
        url = parsedRecord['url'],
        score = parsedRecord['score'],
        title = parsedRecord['title'],
        descendants = parsedRecord['descendants'] ?? 0;

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'parent': parent,
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
      'deleted': deleted ? 1 : 0,
      'dead': dead ? 1 : 0,
      'kids': jsonEncode(kids),
    };
  }
}
