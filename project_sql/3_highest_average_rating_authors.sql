WITH AuthorTotalRatings AS (
    SELECT
        author,
        SUM(num_ratings) AS total_num_ratings
    FROM
        book_details
    GROUP BY
        author
    ORDER BY
        total_num_ratings DESC
    LIMIT 35
),
AvgTotalNumRating AS (
    SELECT
        ROUND(AVG(total_num_ratings), 2) AS avg_total_num_ratings
    FROM
        AuthorTotalRatings
),
AuthorRatings AS (
    SELECT
        author,
        ROUND(AVG(average_rating), 2) AS avg_rating,
        ROUND(AVG(num_ratings), 2) AS avg_num_ratings
    FROM
        book_details
    GROUP BY
        author
),
TopAuthors AS (
    SELECT
        ar.author,
        ar.avg_rating
    FROM 
        AuthorRatings AS ar
    INNER JOIN 
        AvgTotalNumRating AS atnr
    ON 
        (SELECT SUM(num_ratings) FROM book_details WHERE author = ar.author) > atnr.avg_total_num_ratings
    ORDER BY 
        ar.avg_rating DESC
    LIMIT 10
)

SELECT
    ta.author,
    ta.avg_rating
FROM
    TopAuthors AS ta
ORDER BY 
    ta.avg_rating DESC;


/*

+-----------------------+-------------+
|         author        | avg_rating  |
+-----------------------+-------------+
| Sarah J. Maas         |        4.39 |
| Rick Riordan          |        4.31 |
| J.K. Rowling          |        4.29 |
| J.R.R. Tolkien        |        4.29 |
| Taylor Jenkins Reid   |        4.23 |
| Suzanne Collins       |        4.22 |
| Colleen Hoover        |        4.03 |
| Stephen King          |        4.00 |
| John Green            |        3.87 |
| Stephenie Meyer       |        3.81 |
+-----------------------+-------------+

*/