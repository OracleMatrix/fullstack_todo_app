import 'dart:convert';

List<GetTodosModel> getTodosModelFromJson(String str) =>
    List<GetTodosModel>.from(
      json.decode(str).map((x) => GetTodosModel.fromJson(x)),
    );

String getTodosModelToJson(List<GetTodosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTodosModel {
  int? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  int? userId;
  DateTime? completedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetTodosModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.priority,
    this.userId,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GetTodosModel.fromJson(Map<String, dynamic> json) => GetTodosModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    priority: json["priority"],
    userId: json["userId"],
    completedAt:
        json["completedAt"] == null
            ? null
            : DateTime.parse(json["completedAt"]),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "priority": priority,
    "userId": userId,
    "completedAt": completedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
