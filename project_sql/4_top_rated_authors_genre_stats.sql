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
    bg.genre,
    COUNT(bg.genre) AS genre_count
FROM
    book_genres AS bg
INNER JOIN
    book_details AS bd ON bg.book_id = bd.book_id
INNER JOIN
    TopAuthors AS ta ON bd.author = ta.author
GROUP BY
    ta.author, bg.genre
ORDER BY
    ta.author, genre_count DESC;
