SELECT 
    YEAR(cout) AS Year,
    MONTH(cout) AS Month,
    SUM(CASE
        WHEN title = 'Trump The Art of the Deal' THEN 1
        ELSE 0
    END) AS 'Trump: The Art of the Deal',
    SUM(CASE
        WHEN title = 'Trump Think Like a Billionaire' THEN 1
        ELSE 0
    END) AS 'Trump: Think Like a Billionaire',
    SUM(CASE
        WHEN title = 'Youve Been Trumped' THEN 1
        ELSE 0
    END) AS 'Youve Been Trumped'
FROM
    spl_2016.inraw
WHERE
    YEAR(cout) >= '2006'
GROUP BY MONTH(cout) , YEAR(cout)
ORDER BY YEAR(cout) , MONTH(cout)