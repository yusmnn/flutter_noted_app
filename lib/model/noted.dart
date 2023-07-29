import 'dart:convert';

class Noted {
  Noted({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdTime': createdTime.millisecondsSinceEpoch,
    };
  }

  factory Noted.fromMap(Map<String, dynamic> map) {
    return Noted(
        id: map['id']?.toInt(),
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        createdTime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdTime'])));
  }

  String toJson() => json.encode(toMap());

  factory Noted.fromJson(String source) => Noted.fromMap(json.decode(source));

  Noted copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) {
    return Noted(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
