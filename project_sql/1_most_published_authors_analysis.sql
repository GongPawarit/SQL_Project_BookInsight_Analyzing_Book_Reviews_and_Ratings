/*
Dataset Description

book_details.csv
    - book_id: Unique identifier for each book.
    - book_title: Title of the book.
    - publication_info: Additional publication details.
    - author: Author of the book.
    - num_ratings: Number of ratings the book received.
    - num_reviews: Number of reviews the book received.
    - average_rating: Average rating of the book.
    - publication_date: Date when the book was published.

book_genres.csv
    - book_id: Unique identifier for each book.
    - genre: Genre of the book.
*/

WITH author_publications AS (
    SELECT
        author,
        COUNT(DISTINCT book_id) AS num_books
    FROM
        book_details
    GROUP BY
        author
)
SELECT
    author,
    num_books
FROM
    author_publications
ORDER BY
    num_books DESC
LIMIT 10;

