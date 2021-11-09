// To parse this JSON data, do
//
//     final note = noteFromMap(jsonString);

import 'dart:convert';

class Note {
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  int? id;
  String title;
  String description;
  DateTime createdAt;

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Note.fromJson(String str) => Note.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
      };
}
