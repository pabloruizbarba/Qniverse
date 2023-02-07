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
insert into Question values(18,29, "En qué isla vivía Otelo?", "Chipre", "Creta","Sicilia", "Corfú", 3, null, 5, 5, False);
insert into Question values(19,29, "Cuál es el nombre del primer gran poema épico de la literatura inglesa?", "The Battle of Maldon", "Beowulf", "Finnesburg Fragment", "Judith", 2, null, 5, 5, False);
insert into Question values(20,29, "Quién pintó 'Mujer mirando por la ventana'?",  "Pablo Picasso", "Salvador Dalí", "Joan Miró", "René Magritte", 2, null, 5, 5, False);
insert into Question values(21,29, "En qué ciudad nació el pintor y escultor Joan Miro?", "Barcelona", "Madrid", "Valencia", "Sevilla", 1, null, 5, 5, False);
insert into Question values(22,29, "De qué género es la obra 'Luces de Bohemia'?", "Novela", "Poema", "Pintura","Teatro", 4, null, 5, 5, False);
insert into Question values(23,29, "Cuál de los siguientes personajes no aparece en la portada del álbum Sgt. Pepper's Lonely Hearts Club Band, de la banda británica The Beatles?", "Bob Marley", "Alfred Hitchcock", "Mae West", "Edgar Allan Poe", 1, null, 5, 5, False);
insert into Question values(24,29, "Cuál es el baile popular de Aragón?", "Bulerías","Jota", "Sardana", "Rumba", 2, null, 5, 5, False);
insert into Question values(25,29, "En qué año se suicidó Van Gogh?", "1900", "1880", "1895", "1890", 4, null, 5, 5, False);
insert into Question values(26,29, "Cuál es el baile típico de Galicia?", "Sardana","Muiñeira", "Jota", "Sevillanas", 2, null, 5, 5, False);
insert into Question values(27,29, "Quién escribió La Divina Comedia?", "Dante Alighieri", "Francesco Petrarca", "Giovanni Boccaccio", "Torquato Tasso", 1, null, 5, 5, False);
insert into Question values(28,29, "Cuántas cuerdas suele tener un bajo eléctrico?","Seis", "Ocho","Cuatro", "Diez", 3, null, 5, 5, False);
insert into Question values(29,29, "Quién escribió 'El Ejército Negro'?", "Santiago García-Clairac", "Manuel Aznar Soler", "José María Pemán", "Federico García Lorca", 1, null, 5, 5, False);
insert into Question values(30,29, "Cuál de las siguientes obras fue escrita por Wolfgang Amadeus Mozart?", "El Noveno Sinfonía","Réquiem", "La Sinfonía 40", "La Sinfonía 41", 2, null, 5, 5, False);
insert into Question values(31,29, "Para qué sirve la paleta?", "Para mezclar pinturas", "Para medir la técnica de un pintor", "Para sujetar las pinturas", "Para limpiar pinceles", 1, null, 5, 5, False);
insert into Question values(32,29, "Quién escribió 'Azazel'?", "Isaac Asimov", "Isaac Bashevis Singer", "Isaac Newton", "Frank Herbert", 1, null, 5, 5, False);
insert into Question values(33,29, "Cuál es esta bandera?", "Corea del Sur", "Taiwán","Libia", "Japón", 4, "https://img.asmedia.epimg.net/resizer/ECKwX3vbXra-iCyYPDamcEE_UrQ=/1952x1098/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/T3W5EEBTBBDWXMFBH7XV7JYPDM.jpg", 5, 5, False);
insert into Question values(34,29, "De qué marca de coche es este logo?", "Mercedes", "Audi","BMW", "Porsche", 3, "https://m.media-amazon.com/images/I/41-4E5M6wSL._AC_SX355_.jpg", 5, 5, False);
insert into Question values(35,29, "Quién es esta persona?", "Will Smith", "Eto'o","Ronaldinho", "Donato", 2, "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Samuel_2011.jpg/640px-Samuel_2011.jpg", 5, 5, False);
insert into Question values(36,29, "Quién es este actor?", "Tom Cruise", "James McAvoy","Zac Efron", "Brad Pitt", 1, "https://images.mubicdn.net/images/cast_member/2184/cache-2992-1547409411/image-w856.jpg", 5, 5, False);
insert into Question values(37,29, "Quién dirigió esta pelicula?", "Kate Capshaw", "Steven Spielberg","George Lucas", "Martin Scorsese", 2, "https://i.blogs.es/b7822d/jurassic-park-poster/1366_2000.jpg", 5, 5, False);
insert into Question values(38,29, "Quién dirigió esta pelicula?", "Kate Capshaw", "Steven Spielberg","George Lucas", "Martin Scorsese", 4, "https://m.media-amazon.com/images/I/71GrEFp3ywL._SL1102_.jpg", 5, 5, False);
insert into Question values(39,29, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Madrid", 3, "https://imgcap.capturetheatlas.com/wp-content/uploads/2021/08/paris-eiffel-tower-las-vegas-eiffel-tower-restaurant.jpg", 5, 5, False);
insert into Question values(40,30, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Bucarest", 4, "https://www.larumania.es/wp-content/uploads/2016/10/arco_triunfo_bucarest.jpg", 5, 5, False);
insert into Question values(41,30, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Bucarest", 2, "https://farm7.staticflickr.com/6096/6261727676_277bd5bc9d_o.jpg", 5, 5, False);
