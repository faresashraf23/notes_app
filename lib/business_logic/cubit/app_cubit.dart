// ignore_for_file: avoid_print, unused_element

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List notes = [];
  late Database database;
  int pressedIndex = 1;
  int selectedIndex = 1;

  var titleController = TextEditingController();
  var messageController = TextEditingController();
  var dateController = TextEditingController();

  void createDatabase() async {
    String pathDatabase = await getDatabasesPath();
    String path = join(pathDatabase, 'Notes.db');

    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        print("Datebase opened");
        database
            .execute(
                'CREATE TABLE Notes (id INTEGER PRIMARY KEY , title TEXT , message TEXT , date TEXT  )')
            .then((value) {
          print('table created');
        }).catchError((onError) {
          print('Error when creating table ${onError.toString()}');
        });
      },
      onOpen: (database) {
        getDatabase(database);
        print("datebase opened");
      },
    ).then((value) {
      database = value;
      emit(AppGreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String message,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Notes(title, message, date) VALUES("$title", "$message", "$date")')
          .then((value) {
        print("$value inserted successfully");
        emit(AppInsertDatabaseState());

        getDatabase(database);
      }).catchError((error) {
        print("Error when Inserting new record${error.toString()}");
      });
    });
  }

  void getDatabase(database) {
    try {
      database!.rawQuery('SELECT * FROM Notes').then((value) {
        notes = [];
        print(value);
        value.forEach((element) {
          notes.add(element);
          // print("notes added");
        });
        emit(AppGetDatabaseState());
        print("Data got");
      });
    } catch (e) {
      print('getdatabase ${e.toString()}');
    }
  }

  void deleteDatabase(int id) async {
    database.rawDelete('DELETE FROM Notes WHERE id = ?', [id]).then((value) {
      emit(AppdeletingState());

      getDatabase(database);
      emit(AppdeleteDatabaseState());
    });
  }

  updateDatabase({
    required String title,
    required String date,
    required String message,
    required int id,
  }) async {
    database.rawUpdate(
        'UPDATE Notes SET title = ?, date = ?, message = ? WHERE id = ?',
        [title, date, message, id]).then((value) {
      getDatabase(database);
      emit(AppupdateDatabaseState());
    });
  }

  changeIndex(index) {
    pressedIndex = index;
    selectedIndex = notes[index]['id'];

    emit(AppChangeIndexState());
  }
}
