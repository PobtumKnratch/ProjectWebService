import 'dart:convert';

List<Upload4> upload4FromJson(String str) => List<Upload4>.from(json.decode(str).map((x) => Upload4.fromJson(x)));

String upload4ToJson(List<Upload4> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Upload4 {
    Upload4({
        required this.id,
        required this.name,
        required this.image,
        required this.date,
    });

    String id;
    String name;
    String image;
    DateTime date;

    factory Upload4.fromJson(Map<String, dynamic> json) => Upload4(
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