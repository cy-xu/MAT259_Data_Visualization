SELECT 
    ItemNumber, title, count(itemNumber), callNumber
    -- bibNumber, title, COUNT(title), callNumber

FROM
    spl_2016.outraw
WHERE
    title = 'The Looming Tower'
--    YEAR(cout) = 2017
    
--        AND (itemType = 'acdvd' OR itemType = 'ardvd'
--        OR itemType = 'bcdvd'
--        OR itemType = 'jcdvd')
GROUP BY title
ORDER BY COUNT(title) DESC
LIMIT 10000

-- see how Oscar boost the rental of some winner movies