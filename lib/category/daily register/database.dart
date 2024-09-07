import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "DailyRegister.db";
  static final _databaseVersion = 1;
  static final table = 'register';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnRoomNo = 'room_no';
  static final columnEntryDateTime = 'entry_date_time';
  static final columnExitDateTime = 'exit_date_time';
  static final columnReason = 'reason';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnRoomNo TEXT NOT NULL,
            $columnEntryDateTime TEXT NOT NULL,
            $columnExitDateTime TEXT NOT NULL,
            $columnReason TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRowsByDate(String date) async {
    Database? db = await instance.database;
    return await db!.query(
      table,
      where: "$columnEntryDateTime LIKE ?",
      whereArgs: ['$date%'], // Using LIKE to match the date prefix.
    );
  }


}
