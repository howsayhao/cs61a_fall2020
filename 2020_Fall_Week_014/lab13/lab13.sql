.read data.sql


CREATE TABLE average_prices AS
  SELECT category as category, AVG(MSRP) as average_price FROM products group by category; 

-- 基本就是练一下SQL的一些使用和函数,没什么意思
-- 找到每一个产品出售最便宜的店铺
CREATE TABLE lowest_prices AS
  SELECT store as store, item as item, price as average_price FROM inventory
   group by item having min(price); 

-- 找到每一产品类中 最‘便宜’的产品
-- 并找到刚好是该产品出售最便宜的店铺
CREATE TABLE shopping_list AS
  SELECT name, store from products as p, lowest_prices as l
          where p.name = l.item
        group by category having min(MSRP/rating);



CREATE TABLE total_bandwidth AS
  SELECT sum(s.mbs) from stores as s, shopping_list as l
        where s.store = l.store;


