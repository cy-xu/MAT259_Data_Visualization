/*
Steps:
1. Generate Query of Counts per Month
2. Export to Excel
3. Calculate Average and Standard Deviation of each title
4. Created columns and inserted values for Average and Standard Deviation

SELECT 
    title,
    MOD(deweyClass, 641) AS Dewey,
    COUNT(bibNumber) AS Counts,
    SUM(CASE
        WHEN (YEAR(cout) = 2006) THEN 1
        ELSE 0
    END) AS '2006',
    SUM(CASE
        WHEN (YEAR(cout) = 2007) THEN 1
        ELSE 0
    END) AS '2007',
    SUM(CASE
        WHEN (YEAR(cout) = 2008) THEN 1
        ELSE 0
    END) AS '2008',
    SUM(CASE
        WHEN (YEAR(cout) = 2009) THEN 1
        ELSE 0
    END) AS '2009',
    SUM(CASE
        WHEN (YEAR(cout) = 2010) THEN 1
        ELSE 0
    END) AS '2010',
    SUM(CASE
        WHEN (YEAR(cout) = 2011) THEN 1
        ELSE 0
    END) AS '2011',
    SUM(CASE
        WHEN (YEAR(cout) = 2012) THEN 1
        ELSE 0
    END) AS '2012',
    SUM(CASE
        WHEN (YEAR(cout) = 2013) THEN 1
        ELSE 0
    END) AS '2013',
    SUM(CASE
        WHEN (YEAR(cout) = 2014) THEN 1
        ELSE 0
    END) AS '2014',
    SUM(CASE
        WHEN (YEAR(cout) = 2015) THEN 1
        ELSE 0
    END) AS '2015',
    SUM(CASE
        WHEN (YEAR(cout) = 2016) THEN 1
        ELSE 0
    END) AS '2016',
    SUM(CASE
        WHEN (YEAR(cout) = 2017) THEN 1
        ELSE 0
    END) AS '2017'
FROM
    spl_2016.inraw
WHERE
    (FLOOR(deweyClass) = 641) &&
    (deweyClass % 641 < 1)
GROUP BY bibNumber , deweyClass , title
ORDER BY Counts DESC

*/