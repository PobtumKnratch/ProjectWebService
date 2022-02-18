import 'dart:convert';

List<Upload> uploadFromJson(String str) =>
    List<Upload>.from(json.decode(str).map((x) => Upload.fromJson(x)));

String uploadToJson(List<Upload> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Upload {
  Upload({
     required this.id,
     required this.name,
     required this.image,
     required this.date,
  });

  String id;
  String name;
  String image;
  DateTime date;

  factory Upload.fromJson(Map<String, dynamic> json) => Upload(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "date": date.toIso8601String(),
      };
}
