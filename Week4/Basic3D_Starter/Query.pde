/*
SELECT 
    keyword AS Elements,
    TIME(checkOut) AS Times,
    DATE(checkOut) AS Dates,
    title AS Titles,
    COUNT(title) AS Counts
FROM
    spl3.transactions,
    spl3.x_keyword,
    spl3.title
WHERE
    spl3.transactions.bibNumber = spl3.x_keyword.bibNumber
        AND spl3.transactions.bibNumber = spl3.title.bibNumber
        AND (keyword = 'gold' OR keyword = 'water'
        OR keyword = 'fire'
        OR keyword = 'wood')
GROUP BY title
*/