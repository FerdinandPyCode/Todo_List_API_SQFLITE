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
      result.addAll({'beginedAt': beginedAt!.toString()..substring(0, 16)});
    }
    if (finishedAt != null) {
      result.addAll({'finishedAt': finishedAt!.toString()..substring(0, 16)});
    }
    if (deadlineAt != null) {
      result.addAll({'deadlineAt': deadlineAt!.toString()..substring(0, 16)});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.toString()..substring(0, 16)});
    }
    if (createAt != null) {
      result.addAll({'createAt': createAt!.toString()..substring(0, 16)});
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
      id: map['id'] is int ? map['id'].toString() : map['id'],
      description: map['description'],
      title: map['title'],
      beginedAt:
          map['begined_at'] != null ? DateTime.parse(map['begined_at']) : null,
      finishedAt: map['finished_at'] != null
          ? DateTime.parse(map['finished_at'])
          : null,
      deadlineAt: map['deadline_at'] != null
          ? DateTime.parse(map['deadline_at'])
          : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      createAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      priority: map['priority'],
      user: map['user_id'] ?? "",
    );
  }

  factory Todo.fromMap2(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] is int ? map['id'].toString() : map['id'],
      description: map['description'],
      title: map['title'],
      beginedAt: map['beginAt'] != null ? DateTime.parse(map['beginAt']) : null,
      finishedAt:
          map['finishAt'] != null ? DateTime.parse(map['finishAt']) : null,
      deadlineAt:
          map['deadlineAt'] != null ? DateTime.parse(map['deadlineAt']) : null,
      updatedAt:
          map['updateAt'] != null ? DateTime.parse(map['updateAt']) : null,
      createAt:
          map['createAt'] != null ? DateTime.parse(map['createAt']) : null,
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
