import 'dart:convert';

List<Upload3> upload3FromJson(String str) => List<Upload3>.from(json.decode(str).map((x) => Upload3.fromJson(x)));

String upload3ToJson(List<Upload3> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Upload3 {
    Upload3({
        required this.id,
        required this.name,
        required this.image,
        required this.date,
    });

    String id;
    String name;
    String image;
    DateTime date;

    factory Upload3.fromJson(Map<String, dynamic> json) => Upload3(
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