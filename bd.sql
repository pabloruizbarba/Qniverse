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
INSERT INTO League values(1, "Mercury", 1000);
INSERT INTO League values(2, "Venus", 2000);
INSERT INTO League values(3, "Earth", 3000);
INSERT INTO League values(4, "Mars", 4000);
INSERT INTO League values(5, "Jupiter", 5000);
INSERT INTO League values(6, "Saturn", 6000);
INSERT INTO League values(7, "Uranus", 7000);
INSERT INTO League values(8, "Neptune", 8000);

INSERT INTO User values(0, 3, "q-angel", "angel@angel.angel", "qniverse", "1234", "1234", 3000, "17/01/2023");
INSERT INTO User values(0, 3, "q-cesar", "cesar@cesar.cesar", "qniverse", "1234", "1234", 3000, "17/01/2023");
INSERT INTO User values(0, 3, "q-pablo", "pablo@pablo.pablo", "qniverse", "1234", "1234", 3000, "17/01/2023");
INSERT INTO User values(0, 3, "q-adrian", "adrian@adrian.adrian", "qniverse", "1234", "1234", 3000, "17/01/2023");

INSERT INTO Question values(1, 1, "Cuánto es 5+5", "10", "5", "15", "20", 1, null, 10, 5, True);
INSERT INTO Question values(2, 1, "Qué hecho histórico corresponde al día D?", "Desembarco de Normandía", "Liberarión de París", "Rendición de los Nazis", "Bombardeo sobre Londres", 1, null, 5, 5, False);
INSERT INTO Question values(3, 1, "Qué líquido suele ser utilizado para purificar cañerías tapadas?", "Alcohol etílico", "Ácido Hialuronico", "Manaos", "Soda cáustica", 3, null, 10, 5, True);
INSERT INTO Question values(4, 1, "Qué celebran los cristianos el 25 de diciembre?", "La muerte de Jesús", "El nacimiento de Jesús", "La resurreción de Jesús", "La crucifixión de Jesús", 2, null, 15, 5, True);
INSERT INTO Question values(18,1, "En qué isla vivía Otelo?", "Chipre", "Creta","Sicilia", "Corfú", 3, null, 5, 5, False);
INSERT INTO Question values(19,1, "Cuál es el nombre del primer gran poema épico de la literatura inglesa?", "The Battle of Maldon", "Beowulf", "Finnesburg Fragment", "Judith", 2, null, 5, 5, False);
INSERT INTO Question values(20,1, "Quién pintó 'Mujer mirando por la ventana'?",  "Pablo Picasso", "Salvador Dalí", "Joan Miró", "René Magritte", 2, null, 5, 5, False);
INSERT INTO Question values(21,1, "En qué ciudad nació el pintor y escultor Joan Miro?", "Barcelona", "Madrid", "Valencia", "Sevilla", 1, null, 5, 5, False);
INSERT INTO Question values(22,1, "De qué género es la obra 'Luces de Bohemia'?", "Novela", "Poema", "Pintura","Teatro", 4, null, 5, 5, False);
INSERT INTO Question values(23,1, "Cuál de los siguientes personajes no aparece en la portada del álbum Sgt. Pepper's Lonely Hearts Club Band, de la banda británica The Beatles?", "Bob Marley", "Alfred Hitchcock", "Mae West", "Edgar Allan Poe", 1, null, 5, 5, False);
INSERT INTO Question values(24,1, "Cuál es el baile popular de Aragón?", "Bulerías","Jota", "Sardana", "Rumba", 2, null, 5, 5, False);
INSERT INTO Question values(25,1, "En qué año se suicidó Van Gogh?", "1900", "1880", "1895", "1890", 4, null, 5, 5, False);
INSERT INTO Question values(26,1, "Cuál es el baile típico de Galicia?", "Sardana","Muiñeira", "Jota", "Sevillanas", 2, null, 5, 5, False);
INSERT INTO Question values(27,1, "Quién escribió La Divina Comedia?", "Dante Alighieri", "Francesco Petrarca", "Giovanni Boccaccio", "Torquato Tasso", 1, null, 5, 5, False);
INSERT INTO Question values(28,1, "Cuántas cuerdas suele tener un bajo eléctrico?","Seis", "Ocho","Cuatro", "Diez", 3, null, 5, 5, False);
INSERT INTO Question values(29,1, "Quién escribió 'El Ejército Negro'?", "Santiago García-Clairac", "Manuel Aznar Soler", "José María Pemán", "Federico García Lorca", 1, null, 5, 5, False);
INSERT INTO Question values(30,1, "Cuál de las siguientes obras fue escrita por Wolfgang Amadeus Mozart?", "El Noveno Sinfonía","Réquiem", "La Sinfonía 40", "La Sinfonía 41", 2, null, 5, 5, False);
INSERT INTO Question values(31,1, "Para qué sirve la paleta?", "Para mezclar pinturas", "Para medir la técnica de un pintor", "Para sujetar las pinturas", "Para limpiar pinceles", 1, null, 5, 5, False);
INSERT INTO Question values(32,1, "Quién escribió 'Azazel'?", "Isaac Asimov", "Isaac Bashevis Singer", "Isaac Newton", "Frank Herbert", 1, null, 5, 5, False);
INSERT INTO Question values(33,1, "Cuál es esta bandera?", "Corea del Sur", "Taiwán","Libia", "Japón", 4, "https://img.asmedia.epimg.net/resizer/ECKwX3vbXra-iCyYPDamcEE_UrQ=/1952x1098/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/T3W5EEBTBBDWXMFBH7XV7JYPDM.jpg", 5, 5, False);
INSERT INTO Question values(34,1, "De qué marca de coche es este logo?", "Mercedes", "Audi","BMW", "Porsche", 3, "https://m.media-amazon.com/images/I/41-4E5M6wSL._AC_SX355_.jpg", 5, 5, False);
INSERT INTO Question values(35,1, "Quién es esta persona?", "Will Smith", "Eto'o","Ronaldinho", "Donato", 2, "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Samuel_2011.jpg/640px-Samuel_2011.jpg", 5, 5, False);
INSERT INTO Question values(36,1, "Quién es este actor?", "Tom Cruise", "James McAvoy","Zac Efron", "Brad Pitt", 1, "https://images.mubicdn.net/images/cast_member/2184/cache-2992-1547409411/image-w856.jpg", 5, 5, False);
INSERT INTO Question values(37,1, "Quién dirigió esta pelicula?", "Kate Capshaw", "Steven Spielberg","George Lucas", "Martin Scorsese", 2, "https://i.blogs.es/b7822d/jurassic-park-poster/1366_2000.jpg", 5, 5, False);
INSERT INTO Question values(38,1, "Quién dirigió esta pelicula?", "Kate Capshaw", "Steven Spielberg","George Lucas", "Martin Scorsese", 4, "https://m.media-amazon.com/images/I/71GrEFp3ywL._SL1102_.jpg", 5, 5, False);
INSERT INTO Question values(39,1, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Madrid", 3, "https://imgcap.capturetheatlas.com/wp-content/uploads/2021/08/paris-eiffel-tower-las-vegas-eiffel-tower-restaurant.jpg", 5, 5, False);
INSERT INTO Question values(40,1, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Bucarest", 4, "https://www.larumania.es/wp-content/uploads/2016/10/arco_triunfo_bucarest.jpg", 5, 5, False);
INSERT INTO Question values(41,1, "Dónde está tomada esta fotografía?", "Tokyo", "París","Las Vegas", "Bucarest", 2, "https://farm7.staticflickr.com/6096/6261727676_277bd5bc9d_o.jpg", 5, 5, False);
INSERT INTO Question values(42,1, "¿A qué edad alcanzan la madurez las crías de elefante?", "8-10 años", "16-18 años","10-12 años", "12-15 años", 4, null, 6, 5, True);
INSERT INTO Question values(43,1, "¿Cuál es el nombre de la montaña más alta de la Tierra?", "Monte Everest", "Monte Fuji","Monte Kilimanjaro", "Monte Blanc", 1, null, 6, 5, True);
INSERT INTO Question values(44,1, "¿Cuántas células de esperma fabrican los testículos de un hombre al día?", "10 millones", "100 millones","1 millon", "5 millones", 1, null, 6, 5, True);
INSERT INTO Question values(45,1, "¿Qué nombre tiene el portátil más ligero, en peso, de Apple? ", "MacBook Air", "MacBook","MacBook Pro", "iMac", 1, null, 6, 5, True);
INSERT INTO Question values(46,1, "¿Cómo llaman los dentistas a 'matar un nervio'?", "Extracción", "Protesis","Exodoncia", "Endodoncia", 4, null, 6, 5, True);
INSERT INTO Question values(47,1, "¿Quienes fundaron la marca Apple?", "S.Wozniak y R.Jobs", "S.Jobs y S.Wozniak","T. Cook y S.Jobs", "S.Wozniak y T. Cook", 2, null, 6, 5, True);
INSERT INTO Question values(48,1, "¿Cuál de las siguientes enfermedades es muy común en los mayores por la disminución de la densidad de los huesos?", "Arthritis", "Osteoporosis ","Artrosis", "Huesos rotos", 2, null, 6, 5, True);
INSERT INTO Question values(49,1, "¿Qué parte del cuerpo tiene 27 huesos y 35 músculos?", "Pie", "Mano","Rodilla", "Codo", 2, null, 6, 5, True);
INSERT INTO Question values(50,1, "¿Cuál de estos animales es endémico de Colombia?", "Titi gris", "Monito del monte","Koala", "Kangaroo", 1, null, 6, 5, True);
INSERT INTO Question values(51,1, "¿En matemáticas, ¿qué es 3,14?", "Pi", "Euler","Logaritmo", "Seno", 1, null, 6, 5, True);
INSERT INTO Question values(52,1, "¿Qué animal puede correr sobre el agua?", "Sapo", "Rana","Lagarto basilisco", "Salamandra", 3, null, 6, 5, True);
INSERT INTO Question values(53,1, "¿Qué duración tiene un partido de fútbol que llega a la tanda de penaltis?", "120", "90","100", "150", 1, null, 6, 5, True);
INSERT INTO Question values(54,1, "¿En cuál de los siguientes deportes se puede tocar el balón con las manos?", "Fútbol", "Baloncesto","Fútbol Sala", "Voleibol", 2, null, 6, 5, True);
INSERT INTO Question values(55,1, "¿Cómo se llamaba la pelota del Mundial de Fútbol 1978?", "Telstar", "Adidas Tango","Tango River Plate", "Tango España", 2, null, 6, 5, True);
INSERT INTO Question values(56,1, "¿Cuál es el nombre de pila del tenista Federer?", "Rafael", "Roger","Novak", "Andre", 2, null, 6, 5, True);
INSERT INTO Question values(57,1, "¿Quién es el goleador(es) del mundial 2010?", "Thomas Müller y Diego Forlán", "Cristiano Ronaldo","Lionel Messi", "Neymar", 1, null, 5, 5, False);
INSERT INTO Question values(58,1, "¿Con qué deporte relacionarías a Aitor Osa?", "Golf", "Atletismo", "Natación", "Ciclismo", 4, null, 5, 5, False);
INSERT INTO Question values(59,1, "¿A qué deporte pertenece la WWE?", "Boxeo", "Lucha libre", "Futbol Americano", "Karate", 2, null, 5, 5, False);
INSERT INTO Question values(60,1, "¿En cuántos mundiales participó la selección de Inglaterra?", "14", "10", "15", "12", 1, null, 5, 5, False);
INSERT INTO Question values(61,1, "¿En qué país ganó Alemania su primer mundial de fútbol?", "Italia", "España", "Argentina", "Suiza", 4, null, 5, 5, False);
INSERT INTO Question values(57, 1, "¿Quién era Jay-Jay?", "Un avioncito", "Un dinosaurio", "Un perro", "Un gato", 1, null, 6, 5, True);
INSERT INTO Question values(58, 1, "¿Qué capitán pirata es una mezcla de criaturas del mar y forma humana en las películas de Piratas del Caribe?", "Davy Jones", "Barbossa", "Hector Barbossa", "Jack Sparrow", 1, null, 6, 5, True);
INSERT INTO Question values(59, 1, "¿Quién es el creador del talent show 'The X Factor'?", "Simon Cowell", "Ryan Seacrest", "Idol", "Tom Cruise", 1, null, 6, 5, True);
INSERT INTO Question values(60, 1, "¿Cómo se llama el personaje del videojuego Grand Theft Auto IV?", "Niko", "Tommy", "Franklin", "Michael", 1, null, 6, 5, True);
INSERT INTO Question values(61, 1, "¿Qué fruta es la casa de Bob Esponja?", "Una piña", "Una manzana", "Un durazno", "Una sandía", 1, null, 6, 5, True);
INSERT INTO Question values(62, 1, "¿Quién es el marido de la actriz Angelina Jolie?", "George Clooney", "Johnny Depp", "Brad Pitt", "Pitt", 3, null, 6, 5, True);
INSERT INTO Question values(63, 1, "¿Cómo se llama la actriz que interpreta a una pequeña vampira en 'Entrevista con el vampiro'?", "Emma Watson", "Kirsten Dunst", "Charlotte Gainsbourg", "Winona Ryder", 2, null, 6, 5, True);
INSERT INTO Question values(64, 1, "En el juego preguntados, de qué color es el muñeco de arte?", "Verde", "Azul", "Rojo", "Amarillo", 3, null, 6, 5, True);
INSERT INTO Question values(65, 1, "En la serie Los Simpson de qué color son las perlas de Lisa?", "Verdes", "Rojas", "Azules", "Blancas", 4, null, 6, 5, True);
INSERT INTO Question values(66, 1, "¿Quién dirigió la película 'La Diligencia'?", "Alfred Hitchcock", "Martin Scorsese", "Steven Spielberg", "John Ford", 4, null, 6, 5, True);
INSERT INTO Question values(67, 1, "¿Cómo se llama el vocalista de los Guns 'N' Roses?", "Slash", "Axl Rose", "Duff McKagan", "Izzy Stradlin", 1, null, 6, 5, True);
INSERT INTO Question values(57,2, "¿Cuál es el área urbana más poblada de la India?", "Bombay", "Nueva Delhi", "Chennai", "Hyderabad", 1, null, 6, 5, True);
INSERT INTO Question values(58,2, "¿En qué provincia se encuentra Elche?", "Valencia", "Alicante", "Castellón", "Murcia", 2, null, 6, 5, True);
INSERT INTO Question values(59,2, "¿Cuál es la moneda oficial de Costa Rica?", "Balboa panameño", "Peso colombiano", "Colón costarricense", "Lempira hondureño", 3, null, 6, 5, True);
INSERT INTO Question values(60,2, "¿Cuál de los siguientes países no es una isla?", "Trinidad y Tobago", "Bahamas", "Jamaica", "Todos son islas", 4, null, 6, 5, True);
INSERT INTO Question values(61,2, "¿Dónde se encuentra la isla de Koh Samui?", "Tailandia", "Indonesia", "Malasia", "Filipinas", 1, null, 6, 5, True);
INSERT INTO Question values(62,2, "¿Cuál es la capital de Uruguay?", "Salto", "Montevideo", "Paysandú", "Rocha", 2, null, 6, 5, True);
INSERT INTO Question values(63,2, "¿Dónde se encuentra el río Nilo?", "En América", "En Asia", "En África", "En Europa", 3, null, 6, 5, True);
INSERT INTO Question values(64,2, "¿Dónde se encuentra la villa portuaria más antigua de Francia?", "Le Havre", "Burdeos", "Niza", "Marseille", 4, null, 5, 5, False);
INSERT INTO Question values(65,2, "¿De dónde es el queso D.O. Idiazábal?", "Gipuzkoa", "Álava", "Navarra", "La Rioja", 1, null, 5, 5, False);
INSERT INTO Question values(66,2, "¿Cómo se llama el presidente de la República de Ecuador?", "Lenín Moreno", "Rafael Correa", "Lucio Gutiérrez", "Juan Manuel Santos", 2, null, 5, 5, False);
INSERT INTO Question values(67,2, "¿Cuál es el sexto país más grande el mundo?", "Canadá", "Argentina", "Australia", "India", 3, null, 5, 5, True);
INSERT INTO Question values(68,1, "¿Qué animal es este?", "Leopardo", "Pantera","Guepardo", "Puma", 3, "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/TheCheethcat.jpg/250px-TheCheethcat.jpg", 6, 5, True);
INSERT INTO Question values(69,1, "¿Qué animal es este?", "Zorro pardo", "Hiena","Cancerbero", "Licaón", 4, "https://i.pinimg.com/550x/7b/29/5b/7b295bc9156c1ec0d1a03c8fe599c20c.jpg", 5, 5, False);
INSERT INTO Question values(70,1, "¿Quién creó a este personaje?", "Goscinny", "Hergé","Ibañez", "Uderzo", 2, "http://www.tintin.com/tintin/persos/tintin/tintin.jpg", 6, 5, True);
INSERT INTO Question values(71,1, "¿Quién creó a este personaje?", "A. de Saint-Exupéry", "A. Camus","P. Coelho", "G. Flaubert", 1, "https://www.sopadesapo.com//imagenes_grandes/9788419/978841947209.JPG", 5, 5, False);
INSERT INTO Question values(72,1, "¿A qué país pertenece esta bandera?", "Bolivia", "Camerún","Lituania", "Mali", 3, "https://st2.depositphotos.com/2169563/10099/i/600/depositphotos_100994746-stock-photo-lithuania-flag-waving-on-the.jpg", 6, 5, True);
INSERT INTO Question values(73,1, "¿A qué país pertenece esta bandera?", "Estados Unidos", "Chile","Puerto Rico", "Liberia", 4, "https://www.banderasphonline.com/wp-content/uploads/2020/05/comprar-bandera-liberia-para-mastil-exterior-interior.png", 5, 5, False);
INSERT INTO Question values(74,1, "¿A qué país pertenece esta bandera?", "Estados Unidos", "Chile","Puerto Rico", "Liberia", 2, "https://www.banderas-mundo.es/data/flags/w580/cl.png", 6, 5, True);
INSERT INTO Question values(75,1, "¿En qué ciudad se encuentra este reloj?", "Praga", "Budapest","Cracovia", "Colonia", 1, "https://viajes.nationalgeographic.com.es/medio/2021/07/08/reloj-astronomico-praga_8af577de_550x807.jpg", 5, 5, False);
INSERT INTO Question values(76,1, "¿En qué ciudad se encuentra esta estatua?", "Praga", "Budapest","Bremen", "Salzburgo", 3, "https://cdn.pixabay.com/photo/2015/04/13/18/50/bremen-musicians-721078_640.jpg", 6, 5, True);
INSERT INTO Question values(77,1, "¿Cómo se llama esta tarta?", "Selva negra", "Strudel","Pavlova", "Sacher", 4, "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Wien_-_Sachertorte.jpg/800px-Wien_-_Sachertorte.jpg", 5, 5, False);
