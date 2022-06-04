CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name, b.size FROM dogs AS a, sizes AS b 
      WHERE a.height > b.min AND a.height <= b.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT a.child FROM parents AS a, dogs AS b
      WHERE a.parent = b.name ORDER BY -b.height;


-- Filling out this helper table is optional
-- 是sibling,之前一直卡在把parent也算入sibling
-- 题意没有仔细理解,没认真看题
CREATE TABLE siblings AS
  SELECT p1.child as s1, p2.child as s2, s1.size as size from parents as p1, parents as p2, size_of_dogs as s1, size_of_dogs as s2
      where p1.parent = p2.parent and p1.child < p2.child and
            p1.child = s1.name and p2.child = s2.name and s1.size = s2.size;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || s1 || " plus " || s2 || " have the same size: " || size FROM siblings;

