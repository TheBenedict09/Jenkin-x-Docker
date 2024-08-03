import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseAlreadyExists implements Exception {}

class UnableToGetDocuentsDirectory implements Exception {}

class NoDatabase implements Exception {}

class NoteService {
  Database? _db;

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw NoDatabase;
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyExists();
    }
    try {
      final docPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      // Creating a user table
      await db.execute(createUserTable);

      //Creating a Note Table
      await db.execute(createNoteTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocuentsDirectory;
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;

  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() => 'Person, $id, email = $email';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseNote {
  final int id;
  // ignore: non_constant_identifier_names
  final int user_id;
  final String text;
  // ignore: non_constant_identifier_names
  final bool is_synced_with_cloud;

  DatabaseNote(
      {required this.id,
      // ignore: non_constant_identifier_names
      required this.user_id,
      required this.text,
      // ignore: non_constant_identifier_names
      required this.is_synced_with_cloud});

  DatabaseNote.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        user_id = map[userIdColumn] as int,
        text = map[textColumn] as String,
        is_synced_with_cloud = (map[isSyncedColumn] as int) == 1 ? true : false;

  @override
  String toString() =>
      'Person, ID = $id, UserId = $user_id, isSynced = $is_synced_with_cloud, Text = $text';

  @override
  bool operator ==(covariant DatabaseNote other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const dbName = 'notes.db';
const noteTable = 'note';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedColumn = 'is_synced_with_cloud';
// Creating a user table:
const createUserTable = '''
        CREATE TABLE IF NOT EXISTS "user" (
      	"id"	INTEGER NOT NULL,
	      "email"	INTEGER NOT NULL UNIQUE,
	      PRIMARY KEY("id" AUTOINCREMENT)
        );
      ''';
// Creating a Note table:
const createNoteTable = '''
        CREATE TABLE IF NOT EXISTS "notes" (
      	"id"	INTEGER NOT NULL,
	      "user_id"	INTEGER NOT NULL,
	      "text"	TEXT,
	      "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
      	FOREIGN KEY("user_id") REFERENCES "user"("id"),
	      PRIMARY KEY("id" AUTOINCREMENT)
       );
      ''';
