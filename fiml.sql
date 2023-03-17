CREATE DATABASE cinema;

\с cinema;

/*художники, композиторы, монтажеры и пр*/
CREATE TABLE person 
(
    id serial PRIMARY KEY,
    fullname varchar(150) NOT NULL,
    profession CHARACTER VARYING(150) NOT NULL	
);


/*фильмы*/
CREATE TABLE film
(
    id serial PRIMARY KEY,
    title varchar(150) NOT NULL,
    release_year numeric(4) NOT NULL,
    slogan text,
    director_id integer REFERENCES person(id) NOT NULL, 
    screenwriter_id integer REFERENCES person(id) NOT NULL,
    producer_id integer REFERENCES person(id) NOT NULL,
    operator_id integer REFERENCES person(id) NOT NULL,
    composer_id integer REFERENCES person(id) NOT NULL,
    designer_id integer REFERENCES person(id) NOT NULL,
    editor_id integer REFERENCES person(id) NOT NULL,
    budget  numeric(10) NOT NULL,
    marketing numeric(10) NOT NULL,
    revenueUSA numeric(10) NOT NULL,
    revenueOther  numeric(10) NOT NULL,
    revenueAll numeric(10) GENERATED ALWAYS AS (revenueUSA + revenueOther) STORED,
    age numeric(2) NOT NULL,
    rating_mppa varchar(1) NOT NULL,
    time_of_film time without time zone NOT NULL
);

/*жанры*/
CREATE TABLE genre
(
    id serial PRIMARY KEY,
    title varchar(50) NOT NULL
);

/*связь фильмы жанры*/
CREATE TABLE film_genre
(
    film_id integer REFERENCES film(id)NOT NULL,
    genre_id integer REFERENCES genre(id) NOT NULL,
    CONSTRAINT film_genre_id PRIMARY KEY (film_id, genre_id)
);

/*в главных ролях и роли озвучивали*/
CREATE TABLE film_person 
(
    id serial PRIMARY KEY,
    fullname varchar(150) NOT NULL,
    profession CHARACTER VARYING(150) NOT NULL	
);

/*связь фильм и в главных ролях и роли озвучивали*/
CREATE TABLE film_film_person
(
    film_id integer REFERENCES film(id) NOT NULL ,
    film_person_id integer REFERENCES film_person(id) NOT NULL,
    CONSTRAINT film_film_person_id PRIMARY KEY (film_id, film_person_id)
);

/*страны*/
CREATE TABLE country 
(
    id serial PRIMARY KEY,
    title varchar(150) NOT NULL
);

/*связь фильмы и страны*/
CREATE TABLE film_country
(
    film_id integer REFERENCES film(id) NOT NULL ,
    country_id integer REFERENCES country(id) NOT NULL,
    CONSTRAINT film_country_id PRIMARY KEY (film_id, country_id)
);

/*премьера в мире*/
CREATE TABLE premiere_world
(
   id serial PRIMARY KEY,
   country_id integer REFERENCES country(id) NOT NULL,
   quantity numeric(10),
   datepremiere date
);

/*связь фильм и премьера в мире*/
CREATE TABLE film_premiere_world
(
    film_id integer REFERENCES film(id) NOT NULL ,
    premiere_world_id integer REFERENCES premiere_world(id) NOT NULL,
    CONSTRAINT film_premiere_world_id PRIMARY KEY (film_id, premiere_world_id)
);

/*проактчик в России, например west*/
CREATE TABLE distributor
(
   id serial PRIMARY KEY,
   title varchar(150) NOT NULL
);

/*премьера в России*/
CREATE TABLE premiere_ru
(
   id serial PRIMARY KEY,
   distributor_id integer REFERENCES distributor(id) NOT NULL,
   datepremiere date
);

/*связь фильм и премьера в России*/
CREATE TABLE film_premiere_ru
(
    film_id integer REFERENCES film(id) NOT NULL ,
    premiere_ru_id integer REFERENCES premiere_ru(id) NOT NULL,
    CONSTRAINT film_premiere_ru_id PRIMARY KEY (film_id, premiere_ru_id)
);

/*релиз на DVD связь OneToOne чтобы не было нарушения 1NF*/
CREATE TABLE releasedvd
(
   id integer UNIQUE REFERENCES film(id) NOT NULL,
   title varchar(150) NOT NULL, /*дистреьютер релиза на DVD*/
   daterelease date
);