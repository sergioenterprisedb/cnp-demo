DROP TABLE IF EXISTS players cascade;

-- players
-- one record per player
CREATE TABLE players(
  player_id TEXT NOT NULL,
  family_name TEXT,
  given_name TEXT,
  birth_date TEXT,
  goal_keeper int,
  defender int,
  midfielder int,
  forward int,
  count_tournaments INTEGER,
  list_tournaments TEXT,
  player_wikipedia_link TEXT,
  PRIMARY KEY (player_id)
);

