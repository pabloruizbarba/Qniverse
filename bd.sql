DROP DATABASE IF EXISTS qniverse;
CREATE DATABASE qniverse;
use qniverse;

create table League (
  id INTEGER NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(25),
  minElo INTEGER,
  gameElo INTEGER
);


CREATE TABLE User (
  id INTEGER PRIMARY KEY NOT NULL,
  id_league INTEGER NOT NULL,
  username VARCHAR(20),
  email VARCHAR(100),
  password INTEGER,
  tokenPass VARCHAR(100),
  tokenSession VARCHAR(100),
  elo INTEGER,
  eloQuest INTEGER,
  creationDate VARCHAR(100),
  FOREIGN KEY (id_league) REFERENCES League(id) 
);


CREATE TABLE Lobby (
    id INTEGER PRIMARY KEY,
    creationDate VARCHAR(100),
    privateCode TEXT,
    visibility INTEGER,
    id_user INTEGER NOT NULL,
    FOREIGN KEY (id_user) REFERENCES User(id)
);


create table Question(
  id INTEGER NOT NULL auto_increment PRIMARY KEY,
  id_user INTEGER NOT NULL,
  description VARCHAR(200),
  answer1 VARCHAR(50),
  answer2 VARCHAR(50),
  answer3 VARCHAR(50),
  answer4 VARCHAR(50),
  correctAnswer INTEGER,
  image VARCHAR(200),
  FOREIGN KEY (id_user) REFERENCES User(id)
);


CREATE TABLE Game(
    id_user INTEGER NOT NULL,
    id_lobby INTEGER NOT NULL,
    id_question INTEGER NOT NULL,
    time VARCHAR(100),
    success INTEGER,
    FOREIGN KEY (id_user) REFERENCES User(id),
    FOREIGN KEY (id_lobby) REFERENCES Lobby(id),
    FOREIGN KEY (id_question) REFERENCES Question(id)
);
ALTER TABLE Game ADD CONSTRAINT game_id PRIMARY KEY (id_user, id_lobby,id_question);


create table rateQuestion(
  id_user INTEGER NOT NULL,
  id_question INTEGER NOT NULL,
  rating bool,
  FOREIGN KEY (id_user) REFERENCES User(id),
  FOREIGN KEY (id_question) REFERENCES Question(id)
);


ALTER TABLE rateQuestion ADD CONSTRAINT rate PRIMARY KEY (id_user, id_question);