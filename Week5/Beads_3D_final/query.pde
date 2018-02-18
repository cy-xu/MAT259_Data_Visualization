/*
SELECT year(cout), month(cout), floor(deweyClass) as deweyBin, 
       sum(CASE WHEN spl_2016.outraw.title LIKE "%mexic%" THEN 1 ELSE 0 END) as Mexico,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%ireland%" OR spl_2016.outraw.title LIKE "%irish%" THEN 1 ELSE 0 END) as Ireland,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%spain%" OR spl_2016.outraw.title LIKE "%spanish%" THEN 1 ELSE 0 END) as Spain,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%israel%" THEN 1 ELSE 0 END) as Israel,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%egypt%" THEN 1 ELSE 0 END) as Egypt,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%viet%nam%" THEN 1 ELSE 0 END) as Vietnam,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%german%" THEN 1 ELSE 0 END) as Germany,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%russia%" THEN 1 ELSE 0 END) as Russia,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%china%" OR spl_2016.outraw.title LIKE "%chinese%" THEN 1 ELSE 0 END) as China,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%cuba%" THEN 1 ELSE 0 END) as Cuba,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%iraq%" THEN 1 ELSE 0 END) as Iraq,
       sum(CASE WHEN spl_2016.outraw.title LIKE "%japan%" THEN 1 ELSE 0 END) as Japan
FROM spl_2016.outraw
WHERE year(cout) > 2005 AND year(cout) < 2017
  AND deweyClass IS NOT NULL AND deweyClass != ""
  AND (spl_2016.outraw.title LIKE "%mexic%" OR 
       spl_2016.outraw.title LIKE "%ireland%" OR spl_2016.outraw.title LIKE "%irish%" OR
       spl_2016.outraw.title LIKE "%spain%" OR spl_2016.outraw.title LIKE "%spanish%" OR
       spl_2016.outraw.title LIKE "%israel%" OR
       spl_2016.outraw.title LIKE "%egypt%" OR
       spl_2016.outraw.title LIKE "%viet%nam%" OR
       spl_2016.outraw.title LIKE "%german%" OR
       spl_2016.outraw.title LIKE "%russia%" OR
       spl_2016.outraw.title LIKE "%china%" OR spl_2016.outraw.title LIKE "%chinese%" OR
       spl_2016.outraw.title LIKE "%cuba%" OR
       spl_2016.outraw.title LIKE "%iraq%" OR
       spl_2016.outraw.title LIKE "%japan%")
GROUP BY deweyBin, year(cout), month(cout)
ORDER BY deweyBin, year(cout), month(cout);
*/