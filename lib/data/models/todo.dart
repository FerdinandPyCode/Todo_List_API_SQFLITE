// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// import 'dart:convert';

// List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// class Post {
//   Post({
//     this.id,
//     this.content,
//     this.title,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//   });

//   String? id;
//   String? content;
//   String? title;
//   String? userId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   User? user;

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     id: json["id"] == null ? null : json["id"],
//     content: json["content"] == null ? null : json["content"],
//     title: json["title"] == null ? null : json["title"],
//     userId: json["user_id"] == null ? null : json["user_id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//   );
// }

// class User {
//   User({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.email,
//     this.username,
//   });

//   String? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? email;
//   String? username;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"] == null ? null : json["id"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     email: json["email"] == null ? null : json["email"],
//     username: json["username"] == null ? null : json["username"],
//   );
// }

import 'dart:convert';

import 'package:todo_app/data/models/AuthenticatedUser.dart';

class Todo {
  
  String? id;
  String? description;
  String? title;
  DateTime? beginedAt;
  DateTime? finishedAt;
  DateTime? deadlineAt;
  DateTime? updatedAt;
  DateTime? createAt;
  String? priority;
  User? user;
  Todo({
    this.id,
    this.description,
    this.title,
    this.beginedAt,
    this.finishedAt,
    this.deadlineAt,
    this.updatedAt,
    this.createAt,
    this.priority,
    this.user,
  });

  Todo copyWith({
    String? id,
    String? description,
    String? title,
    DateTime? beginedAt,
    DateTime? finishedAt,
    DateTime? deadlineAt,
    DateTime? updatedAt,
    DateTime? createAt,
    String? priority,
    User? user,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      beginedAt: beginedAt ?? this.beginedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      deadlineAt: deadlineAt ?? this.deadlineAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createAt: createAt ?? this.createAt,
      priority: priority ?? this.priority,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(beginedAt != null){
      result.addAll({'beginedAt': beginedAt!.millisecondsSinceEpoch});
    }
    if(finishedAt != null){
      result.addAll({'finishedAt': finishedAt!.millisecondsSinceEpoch});
    }
    if(deadlineAt != null){
      result.addAll({'deadlineAt': deadlineAt!.millisecondsSinceEpoch});
    }
    if(updatedAt != null){
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }
    if(createAt != null){
      result.addAll({'createAt': createAt!.millisecondsSinceEpoch});
    }
    if(priority != null){
      result.addAll({'priority': priority});
    }
    if(user != null){
      result.addAll({'user': user!.id});
    }
  
    return result;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      description: map['description'],
      title: map['title'],
      beginedAt: map['beginedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['beginedAt']) : null,
      finishedAt: map['finishedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['finishedAt']) : null,
      deadlineAt: map['deadlineAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['deadlineAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
      createAt: map['createAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createAt']) : null,
      priority: map['priority'],
      user: map['user'] != null ? User.fromJson(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, description: $description, title: $title, beginedAt: $beginedAt, finishedAt: $finishedAt, deadlineAt: $deadlineAt, updatedAt: $updatedAt, createAt: $createAt, priority: $priority, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.id == id &&
      other.description == description &&
      other.title == title &&
      other.beginedAt == beginedAt &&
      other.finishedAt == finishedAt &&
      other.deadlineAt == deadlineAt &&
      other.updatedAt == updatedAt &&
      other.createAt == createAt &&
      other.priority == priority &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      description.hashCode ^
      title.hashCode ^
      beginedAt.hashCode ^
      finishedAt.hashCode ^
      deadlineAt.hashCode ^
      updatedAt.hashCode ^
      createAt.hashCode ^
      priority.hashCode ^
      user.hashCode;
  }
}

// {
//   "id": "34bc23f5-c22a-462b-a32e-1f3b517e6bf3",
//   "description": "Gazo et Tiako en concert! je ne dois pas rater",
//   "title": "Aller au concert",
//   "begined_at": null,
//   "finished_at": null,
//   "deadline_at": "2022-12-27 12:00:00",
//   "priority": "medium",
//   "user_id": "73b49f16-dbb6-418e-8450-a7ac5cb750de",
//   "created_at": "2022-12-09 14:29:46",
//   "updated_at": "2022-12-09 14:29:46"
// }