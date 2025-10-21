import 'package:desafio_bus2/data/models/user_db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  final String _tableName = 'users';
  final String _colId = 'id';
  final String _colTitle = 'title';
  final String _colFirstName = 'firstName';
  final String _colLastName = 'lastName';
  final String _colEmail = 'email';
  final String _colPhone = 'phone';
  final String _colPictureLarge = 'pictureLarge';
  final String _colPictureMedium = 'pictureMedium';

Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE $_tableName (
    $_colId TEXT PRIMARY KEY,
        $_colTitle TEXT,
        $_colFirstName TEXT,
        $_colLastName TEXT,
        $_colEmail TEXT,
        $_colPhone TEXT,
        $_colPictureLarge TEXT,
        $_colPictureMedium TEXT
    )
    ''');
  }

  Future<int> saveUser(UserDbModel user) async {
    final db = await database;
    return await db.insert(
      _tableName, 
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_colId = ?',
      whereArgs: [id],
    );
  }

  Future<UserDbModel?> getUser(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_colId = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return UserDbModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<UserDbModel>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, 
    (i){
      return UserDbModel.fromMap(maps[i]);
    });
  }
}