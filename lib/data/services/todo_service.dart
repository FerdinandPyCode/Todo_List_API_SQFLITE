import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/sql_database.dart';
import 'package:todo_app/utils/constants.dart';

class TodoService {
  static Future<Todo> create(data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().post('${Constant.BASE_URL}todos',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));

        // Appel à la fonction d'enregistrement de la tâche dans la base de donnée sql
        TodoDataBase.createTodo(data).then((value) {
          if (value!=0){
            print("La tache a été enregistré dans la base de donnné avec l'identifiant $value");
          }else{
            print("Erreur d'enregistrement ");
          }
          
        });
    if (kDebugMode) {
      print(response.data);
    }
    return Todo.fromMap(response.data);
  }


  static Future<List<Todo>> fetch({queryParameters}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';
    var response = await Dio().get('${Constant.BASE_URL}todos',
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"}));
    if (kDebugMode) {
      print(response.data);
    }
    List<Todo> liste = [];

    for (var elt in response.data) {
      liste.add(Todo.fromMap(elt));
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

  static Future<Todo> patch(id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';
    if (kDebugMode) {
      //Mise à jour dans la base de donnée
      TodoDataBase.updateTodo(id).then((value){
        if(value!=0){
          print("Todo mise à jour ");
        }else{
          print("Todo non mise à jour ");
        }
      });
      print('------------------------->');
      print(data);
      print('------------------------->');

      print('${Constant.BASE_URL}todos/$id');
    }

    var response = await Dio().patch('${Constant.BASE_URL}todos/$id',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"}));
    if (kDebugMode) {
      print(response);
    }
    return Todo.fromMap(response.data);
  }

  static Future<Todo> delete(id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

    var response = await Dio().delete('${Constant.BASE_URL}todos/$id',
        options: Options(headers: {"authorization": "Bearer $token"}));
        // Supression du Todo dans la base donnée 
        TodoDataBase.deleteTodo(id).then((value) {
          if(value!=0){
            print('Reussi');
          }{
            print("rejeté");
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