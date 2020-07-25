import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//classe db singleton
class Db {
  Database _instance;

  static final Db _dataBase = Db._internal();
  Db._internal();
  //cria uma instancia da classe apenas uma vez
  factory Db() {
    return _dataBase;
  }
  //recupera o valor da instancia que foi criada no factory para ser usada
  Future<Database> recoverInstance() async {
    if (_instance == null) {
      _instance = await _openDB();
    }
    return _instance;
  }

  //cria as tabelas no banco de dados, se nao houver uma tabela cria uma
  Future<Database> _openDB() async {
    final pathdataBase = await getDatabasesPath();
    final db = await openDatabase(
      join(pathdataBase, 'list_tasks.db'),
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          task TEXT,
          finish INTEGER
        )
        ''');
      },
      version: 1,
    );
    return db;
  }
}
