// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._instance();
//   static Database? _database;
//
//   DatabaseHelper._instance();
//
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await _initDatabase();
//     }
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'rooms.db');
//     return await openDatabase(path, version: 1, onCreate: _createDatabase);
//   }
//
//   void _createDatabase(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE rooms (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         roomNo TEXT,
//         bedNo TEXT,
//         isAvailable INTEGER
//       )
//     ''');
//   }
//
//   Future<int> update(Map<String, dynamic> row) async {
//     final db = await database;
//     return await db.update(
//       'rooms',
//       row,
//       where: 'roomNo = ?',
//       whereArgs: [row['roomNo']],
//     );
//   }
//
//   static const String table = 'rooms';
// }
