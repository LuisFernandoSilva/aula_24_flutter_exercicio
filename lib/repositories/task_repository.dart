import 'package:aula_24_flutter_exercicio/data/db.dart';
import 'package:aula_24_flutter_exercicio/entites/task.dart';

class TaskRepository {
  final Db _db;
  TaskRepository(this._db);
  String errorDb;

  Future<bool> saveTask(Task task) async {
    try {
      var instanceDB = await _db.recoverInstance();
      var result = await instanceDB.insert('tasks', task.forMap());
      return result > 0;
    } catch (e) {
      errorDb = e;
      return false;
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      var instanceDB = await _db.recoverInstance();
      var result = await instanceDB.update('tasks', task.forMap(),
          where: 'id = ?', whereArgs: [task.id]);

      return result > 0;
    } catch (e) {
      errorDb = e;
      return false;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      var instanceDB = await _db.recoverInstance();
      var result =
          await instanceDB.delete('tasks', where: 'id = ?', whereArgs: [id]);

      return result > 0;
    } catch (e) {
      errorDb = e;
      return false;
    }
  }

  Future<List<Task>> recoverTask() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      var instanceDB = await _db.recoverInstance();
      final result = await instanceDB.query('tasks');
      var tasks = result.map((e) => Task.ofMap(e))?.toList();

      return tasks ?? [];
    } catch (e) {
      errorDb = e;
      return e;
    }
  }
}
