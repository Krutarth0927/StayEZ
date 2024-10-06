import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'registration.db');

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Users( '
          'fullName TEXT,'
          ' dob TEXT, '
          'mobileNo TEXT PRIMARY KEY,'
          ' address TEXT, '
          'collageName TEXT,'
          ' nationality TEXT,'
          ' religion TEXT,'
          ' category TEXT,'
          ' currentCourse TEXT, '
          'yearOfStudy TEXT,'
          ' parentName TEXT,'
          ' parentContactNo TEXT, '
          'roomNo TEXT ,'
          'password TEXT)',
    );
  }

  Future<int> saveUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    int res = await dbClient!.insert("Users", user);
    return res;
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result =
    await dbClient!.query("Users", where: "mobileNo = ?", whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<Map<String, dynamic>?> getUserByPhoneAndPassword(String phone,
      String password) async {
    final dbclient = await db;
    List<Map<String, dynamic>> results = await dbclient!.query(
      'users',
      where: 'mobileNo = ? AND password = ?',
      whereArgs: [phone, password],
    );

    if (results.isNotEmpty) {
      return results.first;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    return await dbClient!.query('users');
  }

  Future<void> deleteUser(String phone) async {
    var dbClient = await db;
    await dbClient!.delete(
      'users',
      where: 'mobileNo = ?',
      whereArgs: [phone],
    );
  }

  Future<int> updateUserByMobileNo(String mobileNo,
      Map<String, dynamic> user) async {
    final dbClient = await db;
    return await dbClient!.update(
      'users',
      user,
      where: 'mobileNo = ?',
      whereArgs: [mobileNo],
    );
  }

  Future<Map<String, dynamic>> getUserByMobileNo(String mobileNo) async {
    final dbClient = await db;
    final result = await dbClient!.query(
      'users',
      where: 'mobileNo = ?',
      whereArgs: [mobileNo],
    );
    return result.isNotEmpty ? result.first : {};
  }

  Future<Map<String, dynamic>> getUser1(int id) async {
    final dbClient = await db;
    final result = await dbClient!.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : {};
  }

  Future<int> getRecordCount(String date) async {
    final dbClient = await db; // Ensure you have a method to get the database instance
    final result = await dbClient!.rawQuery(
        'SELECT COUNT(*) FROM records WHERE date = ?', [date]);
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
