SELECT 
    *
FROM
    spl_2016.inraw
WHERE
    title LIKE '%obama%'
        AND YEAR(cout) > 2015
LIMIT 10000

