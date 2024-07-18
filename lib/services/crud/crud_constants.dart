const participantAge = "participant_age";

const participantIdColumn = "participant_id";
const gameLevelGenderColumn = "game_l_g";
const gameTypeColumn = "game_type";

const dbName = 'mimosa.db';
const participantTable = 'participant';
const gameTable = 'game';

const createGameTable = '''CREATE TABLE IF NOT EXISTS "game" (
      "participant_id" TEXT,
      "rtn_l_g" TEXT NOT NULL,
      PRIMARY KEY("participant_id"), 
      FOREIGN KEY("participant_id") REFERENCES "participant"("participant_id")
      );''';

const createParticipantTable = '''CREATE TABLE IF NOT EXISTS "participant" (
      "participant_id" TEXT NOT NULL,
      "participant_age" TEXT NOT NULL,
      PRIMARY KEY("participant_id")
      );''';
