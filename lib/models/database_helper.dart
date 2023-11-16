import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_info.dart';

class DatabaseHelper {
  static final _databaseName = 'users.db';
  static final _databaseVersion = 1;

  static final table = 'user_info';
  static final columnId = 'id';
  static final columnCivilite = 'civilite';
  static final columnNom = 'nom';
  static final columnPrenom = 'prenom';
  static final columnSpecialite = 'specialite';
  static final columnMatieres = 'matieres';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }
  Future<void> initDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'user_info.db'),
      onCreate: (db, version) {
        // Create the 'user_info' table
        return db.execute(
          'CREATE TABLE user_info(id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'civilite TEXT, nom TEXT, prenom TEXT, specialite TEXT, matieres TEXT)',
        );
      },
      version: 1,
    );
    _database = database;
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnCivilite TEXT,
        $columnNom TEXT,
        $columnPrenom TEXT,
        $columnSpecialite TEXT,
        $columnMatieres TEXT
      )
    ''');
  }

  Future<int> insert(UserInfo user) async {
    final db = await instance.database;
    return await db?.insert(table, user.toMap()) ?? 0;
  }

  Future<List<UserInfo>> queryAllUsers() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(table);

    return List.generate(maps.length, (i) {
      return UserInfo.fromMap(maps[i]);
    });
  }

  Future<int> update(UserInfo user) async {
    Database? db = await instance.database;
    return await db!.update(
      table,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    print("ID TO DELETE "+id.toString());
    Database? db = await instance.database;
    return await db!.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db?.delete(table);
  }
}
