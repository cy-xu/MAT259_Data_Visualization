SELECT 
    Title,
    COUNT(title) AS Counts,
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2006-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2006-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2006-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2006-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2006-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2006-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2006-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2006-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2006-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2006-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2006-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2006 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2006-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2007-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2007-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2007-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2007-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2007-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2007-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2007-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2007-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2007-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2007-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2007-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2007 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2007-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2008-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2008-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2008-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2008-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2008-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2008-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2008-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2008-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2008-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2008-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2008-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2008 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2008-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2009-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2009-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2009-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2009-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2009-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2009-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2009-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2009-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2009-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2009-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2009-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2009 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2009-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2010-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2010-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2010-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2010-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2010-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2010-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2010-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2010-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2010-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2010-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2010-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2010 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2010-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2011-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2011-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2011-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2011-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2011-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2011-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2011-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2011-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2011-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2011-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2011-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2011 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2011-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2012-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2012-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2012-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2012-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2012-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2012-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2012-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2012-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2012-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2012-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2012-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2012 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2012-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2013-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2013-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2013-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2013-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2013-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2013-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2013-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2013-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2013-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2013-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2013-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2013 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2013-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2014-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2014-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2014-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2014-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2014-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2014-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2014-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2014-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2014-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2014-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2014-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2014 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2014-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2015-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2015-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2015-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2015-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2015-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2015-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2015-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2015-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2015-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2015-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2015-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2015 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2015-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2016-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2016-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2016-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2016-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2016-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2016-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2016-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2016-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2016-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2016-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2016-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2016 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2016-12',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 1) THEN 1
        ELSE 0
    END) AS '2017-1',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 2) THEN 1
        ELSE 0
    END) AS '2017-2',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 3) THEN 1
        ELSE 0
    END) AS '2017-3',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 4) THEN 1
        ELSE 0
    END) AS '2017-4',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 5) THEN 1
        ELSE 0
    END) AS '2017-5',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 6) THEN 1
        ELSE 0
    END) AS '2017-6',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 7) THEN 1
        ELSE 0
    END) AS '2017-7',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 8) THEN 1
        ELSE 0
    END) AS '2017-8',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 9) THEN 1
        ELSE 0
    END) AS '2017-9',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 10) THEN 1
        ELSE 0
    END) AS '2017-10',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 11) THEN 1
        ELSE 0
    END) AS '2017-11',
    SUM(CASE
        WHEN (YEAR(cout) = 2017 AND MONTH(cout) = 12) THEN 1
        ELSE 0
    END) AS '2017-12'
FROM
    spl_2016.outraw
WHERE
    title = 'Trump The Art of the Deal'
        OR title = 'Trump Think Like a Billionaire'
        OR title = 'Youve Been Trumped'
GROUP BY title
ORDER BY Counts DESC