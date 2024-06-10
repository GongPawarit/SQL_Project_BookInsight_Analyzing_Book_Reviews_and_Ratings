WITH avg_num_ratings AS (
    SELECT AVG(num_ratings) AS avg_ratings
    FROM book_details
),
deduplicated_books AS (
    SELECT
        book_id,
        book_title,
        publication_info,
        author,
        num_ratings,
        num_reviews,
        average_rating,
        publication_date,
        ROW_NUMBER() OVER (PARTITION BY book_title ORDER BY num_ratings DESC) AS rn
    FROM
        book_details
)

SELECT
    book_title,
    author,
    num_ratings,
    average_rating
FROM
    deduplicated_books
WHERE
    rn = 1
    AND num_ratings > (SELECT avg_ratings FROM avg_num_ratings)
ORDER BY
    average_rating DESC
LIMIT 10;
