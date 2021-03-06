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

  ItemModel({this.by, this.dead, this.deleted, this.descendants, this.id, this.kids, this.parent, this.score, this.text, this.time, this.title, this.type, this.url});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      deleted: json['deleted'] ?? false,
      type: json['type'],
      by: json['by'],
      time: json['time'],
      text: json['text'] ?? '',
      dead: json['dead'] ?? false,
      parent: json['parent'],
      kids: json['kids'] ?? [],
      url: json['url'],
      score: json['score'],
      title: json['title'],
      descendants: json['descendants']
    );
  }

  ItemModel.fromDB(Map<String, dynamic> json) 
    : id = json['id'],
      deleted = json['deleted'] == 1,
      type = json['type'],
      by = json['by'],
      time = json['time'],
      text = json['text'] ?? '',
      dead = json['dead'] == 1,
      parent = json['parent'],
      kids = jsonDecode(json['kids']) ?? [],
      url = json['url'],
      score = json['score'],
      title = json['title'],
      descendants = json['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deleted': deleted ? 1 : 0,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead ? 1 : 0,
      'parent': parent,
      'kids': jsonEncode(kids),
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants
    };
  }
}