  
import 'package:sqflite/sqflite.dart' as sql;
  /* We implemente on this file the differents functions to setup our database */
  import '../models/AuthenticatedUser.dart';
import '../models/todo.dart';

class TodoDataBase {
  static final List <Todo> allTodo=[];

    static Future <List <Todo>> get todo async {
    getAllTodo();
      return allTodo;
    }

//Fonction d'initialisation de la base de donnée
    static Future <sql.Database> _initDB() async {
      
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

  /*static Future <void> addColumnToTable()async{
    final db=TodoDataBase._initDB();
    final data={};
  }*/

   /* static Future<int> createAccount(User user) async {
      try {
        sql.Database db = await TodoDataBase._initDB();
        final id = await db.insert('user', user.tojson());
        await TodoDataBase.close();
        return id;
      } catch (e) {
        print(e);
        print("xdcfvgbhnj,k;l:m");
        return -1;
      }
    }*/


    /*static Future <bool> login(String mail, String password) async {
      /*
      The function is to login in the application
      Parametter:{mail:string,password:string}
      */
      try {
        sql.Database db = await TodoDataBase._initDB();

        final maps = await db.query('user', columns: [
          'email',
          'username',
        ]);

        for (int i = 0; i < maps.length; i++) {
          if (maps[i]["email"] == mail && maps[i]["password"] == password) {
            await TodoDataBase.close();
            return true;
          }
        }

        return false;
      } catch (e) {
        return false;
      }
    }*/


  //------------------------------------------------------The methode for Todo/Todo CRUD---------------------------------------------------------
  //Create Todo
  static Future <int> createTodo(Map<String,String>map) async {
      try{
      sql.Database db = await TodoDataBase._initDB();
      print(map);
      final id = await db.insert('todo', map);
      print("L'identifiant du Todo crée est $id");
      await TodoDataBase.close();
      return id;
      }catch (e){
        print(e);
        return -1;
      }
    }


//Get all Todo
static Future <List<Todo>> getAllTodo() async {
    try{
      sql.Database db = await TodoDataBase._initDB();
      final resultat=await db.query('todo', orderBy: "id",);
      for (int i=0;i<resultat.length;i++){
        print(resultat[i]);
        allTodo.add(Todo.fromMap(resultat[i]));
      }
      await TodoDataBase.close();
      return allTodo;
    }catch (e){
        print("ereruhzbkzbhknb kn $e");
      return [];
    
    }
    }


//Get Todo by id
    static Future <Todo> getOneTodo(int id)async {
      
      try{
        sql.Database db= await TodoDataBase._initDB();
      final maps=await db.query('todo',where: "id = ?",whereArgs: [id],limit: 1);
      await TodoDataBase.close();
      return Todo.fromMap(maps.first);
      }catch (e){
        print(e);
        rethrow;
      }
    }


//Update toto
  static Future <int> updateTodo(Map<String,String>map,String id) async{

    try{
    sql.Database db =await  TodoDataBase._initDB();
    final result=db.update('todo', map,where: "id = ?",whereArgs:[id] );
    await TodoDataBase.close();
    return result;
    }catch (e){
      print(e);
      return -1;
    }
  }


//Delete Todo
  static Future <int> deleteTodo(int id)async{
  try{
    final db= await TodoDataBase._initDB();
    await db.delete('todo',where: "id = ?",whereArgs: [id]);
    print("L'identifiant du Todo suprimé est $id ");
    await TodoDataBase.close();
    return id;
  }catch (e){
    print(e);
    return -1;
  }
  }


// Serach todo
static Future<bool>researchTodo(String name)async{
return true;
}

    static Future close() async {
      //This function is use for close the database .It take any parametter
      final db = await TodoDataBase._initDB();
      db.close();
    }
  }
