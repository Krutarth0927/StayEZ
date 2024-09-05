// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:stayez/login(user)/usermodel.dart';
//
// class DatabaseHelper {
//   final databaseName = "notes.db";
//
//   String users =
//       "create table users (userId INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT UNIQUE, userPassword TEXT)";
//
//   Future<Database> initDB() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, databaseName);
//
//     return openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute(users);
//     });
//   }
//
// //
// //   var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
// //   return theDb;
// // }
//
//
//   Future<bool> login(Users users) async {
//     final Database db = await initDB();
//
//     var result = await db.rawQuery(
//         "select * from users where userName = '${users
//             .userName}' AND userPassword = '${users.userPassword}'");
//     return result.isNotEmpty;
//   }
//
//   Future<int> signup(Users user) async {
//     final Database db = await initDB();
//
//     return db.insert('users', user.toMap());
//   }
// }