DROP DATABASE IF EXISTS qniverse;
CREATE DATABASE qniverse;
use qniverse;

create table League (
  id INTEGER NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(25),
  minElo INTEGER
);


CREATE TABLE User (
  id INTEGER NOT NULL auto_increment PRIMARY KEY,
  id_league INTEGER,
  username VARCHAR(20),
  email VARCHAR(100),
  pass VARCHAR(100),
  tokenPass VARCHAR(100),
  tokenSession VARCHAR(100),
  elo INTEGER,
  -- eloQuest INTEGER,
  creationDate VARCHAR(100),
  FOREIGN KEY (id_league) REFERENCES League(id) 
);


CREATE TABLE Lobby (
    id INTEGER NOT NULL auto_increment PRIMARY KEY,
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
  upVotes INTEGER,
  downVotes INTEGER,
  activatedInGame BOOLEAN,
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
  rating boolean,
  FOREIGN KEY (id_user) REFERENCES User(id),
  FOREIGN KEY (id_question) REFERENCES Question(id)
);


ALTER TABLE rateQuestion ADD CONSTRAINT rate PRIMARY KEY (id_user, id_question);




-----------------------------      EXAMPLE DATA FOR DEVELOP     --------------------------------


-- Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
insert into League values(1, "Mercury", 1000);
insert into League values(2, "Venus", 2000);
insert into League values(3, "Earth", 3000);
insert into League values(4, "Mars", 4000);
insert into League values(5, "Jupiter", 5000);
insert into League values(6, "Saturn", 6000);
insert into League values(7, "Uranus", 7000);
insert into League values(8, "Neptune", 8000);

insert into User values(0, 3, "q-angel", "angel@angel.angel", "qniverse", "1234", "1234", 3000, "17/01/2023");
insert into User values(0, 3, "q-cesar", "cesar@cesar.cesar", "qniverse", "1234", "1234", 3000, "17/01/2023");
insert into User values(0, 3, "q-pablo", "pablo@pablo.pablo", "qniverse", "1234", "1234", 3000, "17/01/2023");
insert into User values(0, 3, "q-adrian", "adrian@adrian.adrian", "qniverse", "1234", "1234", 3000, "17/01/2023");

insert into Question values(1, 1, "Cuánto es 5+5", "10", "5", "15", "20", 1, null, 10, 5, True);
insert into Question values(2, 2, "Qué hecho histórico corresponde al día D?", "Desembarco de Normandía", "Liberarión de París", "Rendición de los Nazis", "Bombardeo sobre Londres", 1, null, 5, 5, False);
insert into Question values(3, 3, "Qué líquido suele ser utilizado para purificar cañerías tapadas?", "Alcohol etílico", "Ácido Hialuronico", "Manaos", "Soda cáustica", 3, null, 10, 5, True);
insert into Question values(4, 4, "Qué celebran los cristianos el 25 de diciembre?", "La muerte de Jesús", "El nacimiento de Jesús", "La resurreción de Jesús", "La crucifixión de Jesús", 2, null, 15, 5, True);
