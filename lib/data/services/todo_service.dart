import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/sql_database.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/constants.dart';

class TodoService {
  Ref ref;

  TodoService({
    required this.ref,
  });

  static Future<Todo> create(data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().post('${Constant.BASE_URL}todos',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));

    Todo newTodo = Todo.fromMap(response.data);

    // Appel à la fonction d'enregistrement de la tâche dans la base de donnée sql
    final String userId = prefs.getString(Constant.USER_ID_PREF_KEY) ?? '';
    Map<String, String> data1 = {};
    data1["user"] = userId;
    data1['idSecond'] = newTodo.id ?? "";
    data1["createAt"] = DateTime.now().toString().substring(0, 19);
    data1["updateAt"] = DateTime.now().toString().substring(0, 19);
    data1["title"] = data["title"];
    data1["description"] = data["description"];
    data1["priority"] = data["priority"];
    data1["deadlineAt"] = data["deadline_at"];

    TodoDataBase.createTodo(data1).then((value) {
      if (value != -1) {
        logd(
            "La tache a été enregistré dans la base de donnné avec l'identifiant $value");
      } else {
        logd("Erreur d'enregistrement ");
      }
    });
    if (kDebugMode) {
      logd(response.data);
    }
    return Todo.fromMap(response.data);
  }

  static Future<List<Todo>> fetch({queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    List<Todo> liste = [];

    try {
      var response = await Dio().get('${Constant.BASE_URL}todos',
          queryParameters: queryParameters,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (kDebugMode) {
        logd(response.data);
      }

      for (var elt in response.data) {
        liste.add(Todo.fromMap(elt));
      }
      return liste;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        logd("################################################");
        liste = await TodoDataBase.getAllTodo();
      } else {
        logd(e.message);
      }
    }
    return liste;
  }

  Future<List<Todo>> fetch2({queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    List<Todo> liste = [];

    try {
      var response = await Dio().get('${Constant.BASE_URL}todos',
          queryParameters: queryParameters,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (kDebugMode) {
        logd(response.data);
      }

      for (var elt in response.data) {
        liste.add(Todo.fromMap(elt));
      }
      return liste;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        logd("################################################");
        liste = await TodoDataBase.getAllTodo();
      } else {
        logd(e.message);
      }
    }
    return liste;
  }

  static Future<Todo> get(id, {queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().get('${Constant.BASE_URL}todos/$id',
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"}));

    return Todo.fromJson(response.data);
  }

  static Future<Todo> patch(id, data, {Map<String, String>? dataLocal}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    //Mise à jour dans la base de donnée
    final String userId = prefs.getString(Constant.USER_ID_PREF_KEY) ?? '';
    //int localId = 0;
    TodoDataBase.updateTodo(dataLocal!, id).then((value) {
      if (value != -1) {
        logd("Todo mise à jour ");
      } else {
        logd("Todo non mise à jour ");
      }
    });
    logd('------------------------->');
    logd(data);
    logd('------------------------->');

    logd('${Constant.BASE_URL}todos/$id');

    //try {
    var response = await Dio().patch('${Constant.BASE_URL}todos/$id',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));
    if (kDebugMode) {
      logd(response);
    }
    return Todo.fromMap(response.data);
    //}
    // on DioError catch (e) {
    //   if (e.error is SocketException) {
    //     logd("Network errrrrrrrrrrrrorrrrrrrrr");
    //   } else {
    //     logd(e.message);
    //   }
    // }
    // Todo t = await TodoDataBase.getOneTodo(localId);
    // return t;
  }

  static Future<Todo> delete(id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().delete('${Constant.BASE_URL}todos/$id',
        options: Options(headers: {"authorization": "Bearer $token"}));
    // Supression du Todo dans la base donnée
    TodoDataBase.deleteTodo(id).then((value) {
      if (value != 0) {
        logd('Reussi');
      }
      {
        logd("rejeté");
      }
    });
    return Todo.fromJson(response.data);
  }
}

// Post Format
/**
 * {
 "description": "Gazo et Tiako en concert! je ne dois pas rater",
  "title": "Aller au concert 2",
  "begined_at": "2022-12-27 12:00:00",
  "finished_at": "2022-12-28 12:00:00",
  "deadline_at": "2022-12-29 12:00:00",
  "priority": "medium"
}
 */
