import 'dart:convert';

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
  String? user;
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

  factory Todo.initial() => Todo(
        id: '',
        description: '',
        title: '',
        beginedAt: DateTime.now(),
        finishedAt: DateTime.now(),
        deadlineAt: DateTime.now(),
        updatedAt: DateTime.now(),
        
      );

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
    String? user,
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

    if (id != null) {
      result.addAll({'id': id});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (beginedAt != null) {
      result.addAll({'beginedAt': beginedAt!.millisecondsSinceEpoch});
    }
    if (finishedAt != null) {
      result.addAll({'finishedAt': finishedAt!.millisecondsSinceEpoch});
    }
    if (deadlineAt != null) {
      result.addAll({'deadlineAt': deadlineAt!.millisecondsSinceEpoch});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }
    if (createAt != null) {
      result.addAll({'createAt': createAt!.millisecondsSinceEpoch});
    }
    if (priority != null) {
      result.addAll({'priority': priority});
    }
    if (user != null) {
      result.addAll({'user': user});
    }

    return result;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      description: map['description'],
      title: map['title'],
      beginedAt: map['begined_at'] != null
          ? DateTime.parse(map['begined_at'])
          : null,
      finishedAt: map['finished_at'] != null
          ? DateTime.parse(map['finishedAt'])
          : null,
      deadlineAt: map['deadlineA_at'] != null
          ? DateTime.parse(map['deadline_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
      createAt: map['create_at'] != null
          ? DateTime.parse(map['create_at'])
          : null,
      priority: map['priority'],
      user: map['user'] ?? "",
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