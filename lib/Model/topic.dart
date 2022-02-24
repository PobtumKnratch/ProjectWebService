

// List<Topic> topicFromJson(String str) =>
//     List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

// String topicToJson(List<Topic> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topic {
  Topic({
    // ignore: non_constant_identifier_names
    required this.topic_id,
    // ignore: non_constant_identifier_names
    required this.topic_name,
  });

  // ignore: non_constant_identifier_names
  String topic_id;
  // ignore: non_constant_identifier_names
  String topic_name;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topic_id: json["topic_id"],
        topic_name: json["topic_name"],
      );

  Map<String, dynamic> toJson() => {
        "topic_id": topic_id,
        "topic_name": topic_name,
      };
}
