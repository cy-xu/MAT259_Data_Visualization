SELECT 
    Title, COUNT(bibNumber) AS Counts, bibNumber, Itemtype
FROM
    spl_2016.inraw
WHERE
    title = 'Trump The Art of the Deal'
        OR title = 'Trump Think Like a Billionaire'
        OR title = 'Youve Been Trumped'
        AND YEAR(cout) > 2014
GROUP BY title , bibNumber , itemtype
ORDER BY Counts DESC
LIMIT 1000