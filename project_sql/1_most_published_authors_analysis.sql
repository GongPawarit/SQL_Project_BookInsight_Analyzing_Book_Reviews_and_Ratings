/*
# 1.) Top 10 Most Published Authors Analysis
    This SQL script identifies the top 10 authors with the highest number of published books from a given dataset.
    The dataset comprises three CSV files: 'book_details.csv', 'book_genres.csv', and 'genre_id.csv'.

## Dataset Description

### book_details.csv
    - book_id: Unique identifier for each book.
    - book_title: Title of the book.
    - publication_info: Additional publication details.
    - author: Author of the book.
    - num_ratings: Number of ratings the book received.
    - num_reviews: Number of reviews the book received.
    - average_rating: Average rating of the book.
    - publication_date: Date when the book was published.

### book_genres.csv
    - book_id: Unique identifier for each book.
    - genre: Genre of the book.

### genre_id.csv
    - genre_id: Unique identifier for each genre.
    - genre: Name of the genre.
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

