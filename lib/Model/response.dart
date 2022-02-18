import 'dart:convert';

List<Response> responseFormJson(String str) =>
    List<Response>.from(json.decode(str).map((x) => Response.fromJson(x)));
String responseToJson(List<Response> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Response {
  String id;
  String name;
  String image;
  DateTime date;
  String tag;

  Response(
      {required this.id,
      required this.name,
      required this.image,
      required this.date,
      required this.tag});

  static Response fromJson(json) {
    return Response(
      id: json['id'],
      name: json['name'],
      image: json["image"],
      date: DateTime.parse(json["date"]),
      tag: json['tag'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['image'] = this.image;
  //   data['date'] = date.toIso8601String();
  //   data['tag'] = this.tag;
  //   return data;
    Map<String, dynamic> toJson() => {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    'id': id,
    'name':name,
    'image':image,
    'date': date.toIso8601String(),
    'tag':tag,
    // return data;
  };
}
