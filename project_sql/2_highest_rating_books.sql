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

------------------------------------------

/*

+------------------------------------------------------------------+-------------------+-------------+----------------+
|                            book_title                            |      author       | num_ratings | average_rating |
+------------------------------------------------------------------+-------------------+-------------+----------------+
| Words of Radiance                                                | Brandon Sanderson |      355,368 |           4.76 |
| Harry Potter Series Box Set                                      | J.K. Rowling      |      288,478 |           4.74 |
| Harry Potter Boxed Set, Books 1-5                                | J.K. Rowling      |      148,443 |           4.72 |
| Know My Name                                                     | Chanel Miller     |      202,602 |           4.71 |
| Kingdom of Ash                                                   | Sarah J. Maas     |      566,523 |           4.69 |
| El camino de los reyes                                           | Brandon Sanderson |      500,807 |           4.66 |
| The Way of Kings                                                 | Brandon Sanderson |      500,546 |           4.66 |
| The Essential Calvin and Hobbes: A Calvin and Hobbes Treasury    | Bill Watterson    |      121,178 |           4.65 |
| Manacled                                                         | SenLinYu          |       83,579 |           4.65 |
| A Court of Mist and Fury                                         | Sarah J. Maas     |     1,956,057 |           4.65 |
+------------------------------------------------------------------+-------------------+-------------+----------------+

*/
