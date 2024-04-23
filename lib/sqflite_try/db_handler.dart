import 'dart:io' as io;

import 'package:google_map_practise/sqflite_try/notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initialDatabase();
    return _db;
  }

  initialDatabase() async {
    io.Directory documnetDirectory = await getApplicationDocumentsDirectory();
    String path = join(documnetDirectory.path, 'notes.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT )",
    );
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }
}
