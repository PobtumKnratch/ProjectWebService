// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Upload4 {
  String title;
  String id;
  String user_id;
  String name;
  String description;
  String image;
  String date;
  String tag;
  Upload4({
    required this.title,
    required this.id,
    required this.user_id,
    required this.name,
    required this.description,
    required this.image,
    required this.date,
    required this.tag,
  });

  Upload4 copyWith({
    String? title,
    String? id,
    String? user_id,
    String? name,
    String? description,
    String? image,
    String? date,
    String? tag,
  }) {
    return Upload4(
      title: title ?? this.title,
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'user_id': user_id,
      'name': name,
      'description': description,
      'image': image,
      'date': date,
      'tag': tag,
    };
  }

  factory Upload4.fromMap(Map<String, dynamic> map) {
    return Upload4(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      user_id: map['user_id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      date: map['date'] ?? '',
      tag: map['tag'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Upload4.fromJson(String source) =>
      Upload4.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Upload4(title: $title,id: $id, user_id: $user_id, name: $name, description: $description, image: $image, date: $date, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Upload4 &&
        other.title == title &&
        other.id == id &&
        other.user_id == user_id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.date == date &&
        other.tag == tag;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        user_id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        date.hashCode ^
        tag.hashCode;
  }
}
