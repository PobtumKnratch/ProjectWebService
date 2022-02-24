import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    Food({
        required this.logId,
        required this.userId,
        this.recipeName,
        this.recipeLocalDetail,
        required this.imageContentPath,
        required this.imageTag,
        required this.imageDescription,
        required this.imageTimestamp,
        required this.imageLatitude,
        required this.imageLongitude,
        required this.insertServerTimestamp,
        this.faceAppear,
    });

    String logId;
    String userId;
    dynamic recipeName;
    dynamic recipeLocalDetail;
    String imageContentPath;
    String imageTag;
    String imageDescription;
    DateTime imageTimestamp;
    String imageLatitude;
    String imageLongitude;
    DateTime insertServerTimestamp;
    dynamic faceAppear;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        logId: json["log_id"],
        userId: json["user_id"],
        recipeName: json["recipe_name"],
        recipeLocalDetail: json["recipe_local_detail"],
        imageContentPath: json["image_content_path"],
        imageTag: json["image_tag"],
        imageDescription: json["image_description"],
        imageTimestamp: DateTime.parse(json["image_timestamp"]),
        imageLatitude: json["image_latitude"],
        imageLongitude: json["image_longitude"],
        insertServerTimestamp: DateTime.parse(json["insert_server_timestamp"]),
        faceAppear: json["face_appear"],
    );

    Map<String, dynamic> toJson() => {
        "log_id": logId,
        "user_id": userId,
        "recipe_name": recipeName,
        "recipe_local_detail": recipeLocalDetail,
        "image_content_path": imageContentPath,
        "image_tag": imageTag,
        "image_description": imageDescription,
        "image_timestamp": imageTimestamp.toIso8601String(),
        "image_latitude": imageLatitude,
        "image_longitude": imageLongitude,
        "insert_server_timestamp": insertServerTimestamp.toIso8601String(),
        "face_appear": faceAppear,
    };
}

