import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/todo_service.dart';

final todoController = Provider((ref) => TodoService(ref: ref));
final fetchAllTodo =
    FutureProvider<List<Todo>>((ref) => TodoService(ref: ref).fetch2());
