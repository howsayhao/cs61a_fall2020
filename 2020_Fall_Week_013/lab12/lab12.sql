.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE pet = 'dog' AND color = 'blue';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE pet = 'dog' AND color = 'blue';


CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students WHERE smallest > 2 ORDER BY smallest LIMIT 20 ;


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color FROM students AS a, students AS b
        WHERE a.pet = b.pet AND a.song = b.song AND a.time < b.time;


CREATE TABLE sevens AS
  SELECT seven FROM students AS s, numbers AS n
        WHERE s.number = 7 AND n.'7' = 'True' AND s.time = n.time;



