import 'dart:convert';

GetUserDataModel getUserDataModelFromJson(String str) =>
    GetUserDataModel.fromJson(json.decode(str));

String getUserDataModelToJson(GetUserDataModel data) =>
    json.encode(data.toJson());

class GetUserDataModel {
  int? id;
  String? username;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Todo>? todos;

  GetUserDataModel({
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.todos,
  });

  factory GetUserDataModel.fromJson(
    Map<String, dynamic> json,
  ) => GetUserDataModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    todos:
        json["todos"] == null
            ? []
            : List<Todo>.from(json["todos"]!.map((x) => Todo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "todos":
        todos == null ? [] : List<dynamic>.from(todos!.map((x) => x.toJson())),
  };
}

class Todo {
  int? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  String? category;
  int? userId;
  DateTime? completedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Todo({
    this.id,
    this.title,
    this.description,
    this.status,
    this.priority,
    this.category,
    this.userId,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    priority: json["priority"],
    category: json["category"],
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
    "category": category,
    "userId": userId,
    "completedAt": completedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
