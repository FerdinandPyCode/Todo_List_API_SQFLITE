import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo_app/utils/constants.dart';
/* We implemente on this file the differents functions to setup our database */
import '../models/todo.dart';

class TodoDataBase {
//Fonction d'initialisation de la base de donnée
  static Future<sql.Database> _initDB() async {
    return await sql.openDatabase('contact.db', version: 2,
        onCreate: (sql.Database database, int version) async {
      await _createDB(database);
    });
  }

//Fonction de creation de la base de donnée avec la table Utilisateur
  static Future<void> _createDB(sql.Database db) async {
    await db.execute(""" CREATE TABLE user (
      id  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      email TEXT NOT NULL, 
      username  TEXT NOT NULL, 
      createdAt  TEXT NOT NULL, 
      updatedAt  TEXT NOT NULL)
      """);

    //Creation de la table Todo Todo account
    await db.execute("""CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idSecond TEXT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        beginAt  TEXT ,
        finishAt  TEXT ,
       deadlineAt  TEXT NOT NULL,
        updateAt  TEXT NOT NULL,
        createAt  TEXT NOT NULL,
        priority  TEXT NOT NULL,
        user  TEXT NOT NULL
      )""");
  }

  //------------------------------------------------------The methode for Todo/Todo CRUD---------------------------------------------------------
  //Create Todo
  static Future<int> createTodo(Map<String, String> map) async {
    try {
      sql.Database db = await TodoDataBase._initDB();
      print(map);
      final id = await db.insert('todo', map);
      print("L'identifiant du Todo crée est $id");
      await TodoDataBase.close();
      return id;
    } catch (e) {
      print(e);
      return -1;
    }
  }

//Get all Todo
  static Future<List<Todo>> getAllTodo() async {
    final prefs = await SharedPreferences.getInstance();
    List<Todo> allTodo = [];
    try {
      sql.Database db = await TodoDataBase._initDB();

      String userId = prefs.getString(Constant.USER_ID_PREF_KEY) ?? '';

      final resultat = await db.query(
        'todo',
        where: "user = ?",
        whereArgs: [userId],
        orderBy: "id",
      );
      for (int i = 0; i < resultat.length; i++) {
        print(resultat[i]);
        allTodo.add(Todo.fromMap2(resultat[i]));
      }
      await TodoDataBase.close();
      return allTodo;
    } catch (e) {
      print("ereruhzbkzbhknb kn $e");
      return [];
    }
  }

//Get Todo by id
  static Future<Todo> getOneTodo(String id) async {
    try {
      sql.Database db = await TodoDataBase._initDB();
      final maps =
          await db.query('todo', where: "user = ?", whereArgs: [id], limit: 1);
      await TodoDataBase.close();
      return Todo.fromMap(maps.first);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

//Update toto
  static Future<int> updateTodo(Map<String, String> map, String id) async {
    try {
      sql.Database db = await TodoDataBase._initDB();
      final result =
          db.update('todo', map, where: "idSecond = ?", whereArgs: [id]);
      await TodoDataBase.close();
      return result;
    } catch (e) {
      print(e);
      return -1;
    }
  }

//Delete Todo
  static Future<String> deleteTodo(String id) async {
    try {
      final db = await TodoDataBase._initDB();
      await db.delete('todo', where: "idSecond = ?", whereArgs: [id]);
      print("L'identifiant du Todo suprimé est $id ");
      await TodoDataBase.close();
      return id;
    } catch (e) {
      print(e);
      return "null";
    }
  }

// Serch todo
  static Future<bool> researchTodo(String name) async {
    return true;
  }

  static Future close() async {
    //This function is use for close the database .It take any parametter
    final db = await TodoDataBase._initDB();
    db.close();
  }
}
