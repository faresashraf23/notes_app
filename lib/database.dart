// // ignore_for_file: avoid_print

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// late Database database;
// void createDatabase() async {
//   String pathDatabase = await getDatabasesPath();
//   String path = join(pathDatabase, 'Notes.db');

//   openDatabase(path, version: 1, onCreate: (database, version) {
//     print("Datebase opened");
//     database
//         .execute(
//             'CREATE TABLE Notes (id INTEGER PRIMARY KEY , title TEXT , message TEXT , date TEXT  )')
//         .then((value) {
//       print('table created');
//     }).catchError((onError) {
//       print('Error when creating table ${onError.toString()}');
//     });
//   }, onOpen: (database) {
//     getDatabase(database);
//     print("datebase opened");
//   }).then((value) {
//     database = value;
//   });
// }

// void insertDatabase({
//   required String title,
//   required String message,
//   required String date,
  
// }) {
//   database
//       .rawInsert(
//           'INSERT INTO Notes(title, message, date, color) VALUES("$title", "$message", "$date")')
//       .then((value) {
//     print("$value inserted successfully");
//   });
// }

// void getDatabase(database) {
//   database.rawQuery('SELECT * FROM Test');
// }

// void deleteDatabase(int id) {
//   database.rawDelete('DELETE FROM Notes WHERE id = ?', [id]).then((value) {
//     getDatabase(value);
//   });
// }
