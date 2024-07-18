import 'crud_constants.dart';

class DatabaseNote {
  final String participantId;
  final String gameStat;
  final String gameType;

  DatabaseNote({
    required this.participantId,
    required this.gameStat,
    required this.gameType,
  });

  DatabaseNote.fromRow(Map<String, Object?> map)
      : participantId = map[participantIdColumn] as String,
        gameStat = map[gameLevelGenderColumn] as String,
        gameType = map[gameTypeColumn] as String;

  @override
  String toString() =>
      'Note, participantId = $participantId, gameStat = $gameStat, gameType = $gameType';

  @override
  bool operator ==(covariant DatabaseNote other) =>
      participantId == other.participantId;

  @override
  int get hashCode => participantId.hashCode;
}
