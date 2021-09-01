import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> createConnection() async {
    return openDatabase(join(await getDatabasesPath(), 'todo.db'),
        onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
      await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, description TEXT, isDone INTEGER)');
    }, version: 1);
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await createConnection();
    await _db.insert('tasks', task.getTask(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) => taskId = value);
    return taskId;
  }

   Future<void> deleteTask(int id) async {
    Database _db = await createConnection();
    await _db.delete('tasks', where: 'id = $id');
    await _db.delete('todos', where: 'taskId = $id');
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database db = await createConnection();
    await db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = $id");
  }

    Future<void> updateTaskDescription(int id, String desc) async {
    Database db = await createConnection();
    await db.rawUpdate("UPDATE tasks SET description = '$desc' WHERE id = $id");
  }

    Future<void> updateTodo(int id, int isDone) async {
    Database db = await createConnection();
    await db.rawUpdate("UPDATE todos SET isDone = '$isDone' WHERE id = $id");
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await createConnection();
    await _db.insert('todos', todo.getTodo(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getAllTasks() async {
    Database _db = await createConnection();
    List<Map<String, Object?>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']);
    });
  }

  Future<List<Todo>> getAllTodos() async {
    Database _db = await createConnection();
    List<Map<String, Object?>> todoMap = await _db.query('todos');
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]['id'],
          taskId: todoMap[index]['taskId'],
          description: todoMap[index]['description'],
          isDone: todoMap[index]['isDone']);
    });
  }

    Future<List<Todo>> getTodo(id) async {
    Database _db = await createConnection();
    List<Map<String, Object?>> todoMap = await _db.query('todos',  where: 'taskId=$id');
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]['id'],
          taskId: todoMap[index]['taskId'],
          description: todoMap[index]['description'],
          isDone: todoMap[index]['isDone']);
    }); 
  }
}
