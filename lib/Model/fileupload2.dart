import 'dart:convert';

List<Upload2> upload2FromJson(String str) =>
    List<Upload2>.from(json.decode(str).map((x) => Upload2.fromJson(x)));

String upload2ToJson(List<Upload2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Upload2 {
  Upload2({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.date,
    required this.tag,
  });

  String id;
  String name;
  String description;
  String image;
  DateTime date;
  String tag;

  factory Upload2.fromJson(Map<String, dynamic> json) => Upload2(
        id: json["id"],
        name: json["name"],
        description:json["description"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
        tag: json["tag"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "date": date.toIso8601String(),
        "tag":tag,
      };
}
