import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'complaints.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE complaints(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        room_no TEXT,
        complaint_type TEXT,
        complaint_details TEXT
      )
    ''');
  }

  Future<int> insertComplaint(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('complaints', row);
  }

  Future<List<Map<String, dynamic>>> getComplaints() async {
    Database db = await database;
    return await db.query('complaints');
  }
}
