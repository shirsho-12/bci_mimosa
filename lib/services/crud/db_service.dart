import 'dart:async';

import 'package:mimosa/services/crud/crud_constants.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, MissingPlatformDirectoryException;
import 'package:path/path.dart' show join;
import 'dart:developer' as devtools show log;
import 'package:sqflite/sqflite.dart';

import 'crud_exceptions.dart';
import 'database_note.dart';
import 'database_user.dart';

class DBService {
  Database? _db;
  DatabaseUser? _user;
  final List<DatabaseNote> _notes = [];

  late final StreamController<List<DatabaseNote>> _notesStreamController;

  DBService._sharedInstance() {
    _notesStreamController =
        StreamController<List<DatabaseNote>>.broadcast(onListen: () {
      _notesStreamController.sink.add(_notes);
    });
  }

  static final DBService _shared = DBService._sharedInstance();
  factory DBService() => _shared;

  Future<DatabaseUser> getOrCreateUser({
    required String id,
    bool setAsCurrentUser = true,
  }) async {
    try {
      final user = await getUser(id: id);
      if (setAsCurrentUser) {
        _user = user;
      }
      return user;
    } on CouldNotFindUser {
      final createdUser = await createUser(id: id);
      if (setAsCurrentUser) {
        _user = createdUser;
      }
      return createdUser;
    } catch (e) {
      devtools.log(e.toString());
      rethrow;
    }
  }

  Future<DatabaseNote> createNote({required DatabaseUser owner}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

//     // make sure owner exists in the database with the correct id
    final dbUser = await getUser(id: owner.id);
    if (dbUser != owner) {
      throw CouldNotFindUser();
    }

    const text = '';
    // create the note
    await db.insert(gameTable, {
      participantIdColumn: owner.id,
      gameLevelGenderColumn: text,
      gameTypeColumn: ''
    });

    final note =
        DatabaseNote(participantId: owner.id, gameStat: text, gameType: '');
    _notes.add(note);
    _notesStreamController.add(_notes);
    return note;
  }

  Future<DatabaseUser> getUser({required String id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final results = await db.query(
      participantTable,
      limit: 1,
      where: 'participant_id = ?',
      whereArgs: [id.toLowerCase()],
    );

    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DatabaseUser.fromRow(results.first);
    }
  }

  Future<DatabaseUser> createUser({required String id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      participantTable,
      limit: 1,
      where: "participant_id = ?",
      whereArgs: [id.toLowerCase()],
    );

    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    await db.insert(participantTable, {
      'email': id.toLowerCase(),
    });

    return const DatabaseUser(
      id: participantTable,
      age: 2,
    );
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {
      // empty
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      // create user table
      await db.execute(createParticipantTable);
      // create note table
      await db.execute(createGameTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsException();
    }
  }

  Future<void> close() async {
    final db = _getDatabaseOrThrow();
    await db.close();
    _db = db;
  }
}
