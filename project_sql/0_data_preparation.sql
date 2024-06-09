-- 1. Create the table
CREATE TABLE book_details (
    index SERIAL PRIMARY KEY,
    book_id INT,
    book_title VARCHAR(255),
    publication_info TEXT,
    author VARCHAR(255),
    genres TEXT,
    num_ratings INT,
    num_reviews INT,
    average_rating DECIMAL(3, 2)
);

SELECT *
FROM book_details
ORDER BY index ASC;

SELECT *
FROM book_genres
ORDER BY book_id ASC;

SELECT *
FROM genre_id;

-- 2. Upload data
-- \copy book_details FROM '/Users/GongPawarit/Documents/study/personal_development/Data_Analyst_Projects/1_BookInsight_Analyzing_Book_Reviews_and_Ratings/csv_files/data/book_details.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 3. Remove Duplicate Records (Done)
DELETE FROM book_details
WHERE index NOT IN (
    SELECT MIN(index)
    FROM book_details
    GROUP BY book_id, book_title, author
);
-- Remove duplicate "book_title" by keeping only the highest "num_ratings" for each author
WITH ranked_books AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY book_title, author ORDER BY num_ratings DESC) AS rn
    FROM
        book_details
)
DELETE FROM book_details AS bd
USING ranked_books AS rb
WHERE
    bd.book_id = rb.book_id
    AND rb.rn > 1;



-- 4. Trim Whitespace from Text Fields (Done)
UPDATE book_details
SET
    book_title = TRIM(book_title),
    publication_info = TRIM(publication_info),
    author = TRIM(author),
    genres = TRIM(genres);

-- 5. Normalize Genre Field
-- Create a new table for genres: (Done)
CREATE TABLE book_genres (
    book_id INT,
    genre VARCHAR(255),
    PRIMARY KEY (book_id, genre)
);

-- Populate the new genres table: (Done)
INSERT INTO book_genres (book_id, genre)
SELECT
    book_id,
    UNNEST(STRING_TO_ARRAY(REPLACE(genres, '''', ''), ','))
FROM
    book_details;

-- Remove genres from the original table: (Done)
ALTER TABLE book_details
DROP COLUMN genres;

-- 6. Ensure Ratings and Reviews are Non-negative (Done)
UPDATE book_details
SET
    num_ratings = CASE WHEN num_ratings < 0 THEN 0 ELSE num_ratings END,
    num_reviews = CASE WHEN num_reviews < 0 THEN 0 ELSE num_reviews END;

-- 7. Validate and Clean Dates in 'publication_info' (assuming it should be a DATE type)
-- Extract and format publication date: (Done)
ALTER TABLE book_details
ADD COLUMN publication_date DATE;

-- 8. Update the 'publication date' column (Done)
UPDATE book_details
SET publication_date = TO_DATE(
    regexp_replace(publication_info, '[^0-9, ]', '', 'g') || ' ' || 
    CASE
        WHEN publication_info ~* 'January' THEN 'January'
        WHEN publication_info ~* 'February' THEN 'February'
        WHEN publication_info ~* 'March' THEN 'March'
        WHEN publication_info ~* 'April' THEN 'April'
        WHEN publication_info ~* 'May' THEN 'May'
        WHEN publication_info ~* 'June' THEN 'June'
        WHEN publication_info ~* 'July' THEN 'July'
        WHEN publication_info ~* 'August' THEN 'August'
        WHEN publication_info ~* 'September' THEN 'September'
        WHEN publication_info ~* 'October' THEN 'October'
        WHEN publication_info ~* 'November' THEN 'November'
        WHEN publication_info ~* 'December' THEN 'December'
        ELSE NULL
    END || ' ' || EXTRACT(YEAR FROM TO_DATE(regexp_replace(publication_info, '[^0-9, ]', '', 'g'), 'DD, YYYY')), 
    'DD, YYYY Month YYYY');

-- 9. Update the 'publication_date' column to the Date format (Done)
ALTER TABLE book_details
ALTER COLUMN publication_date TYPE DATE;

-- 10. Removing "[", "]", and "'" from 'publication_info' column (Done)
UPDATE book_details
SET publication_info = REPLACE(REPLACE(REPLACE(publication_info, '[', ''), ']', ''), '''', '');

-- 11. Update the publication_info column to remove date formats (Done)
UPDATE book_details
SET publication_info = REGEXP_REPLACE(publication_info, '[A-Za-z]+\s\d{1,2},\s\d{1,4}', '', 'g');

-- 12. Delete rows where publication_info is empty after the update (Done)
DELETE FROM book_details
WHERE TRIM(publication_info) = '';

-- 13. Update the genres in the book_genres table to clean them
UPDATE book_genres
SET genre = TRIM(BOTH '[] ' FROM genre);

-- 14. Remove rows with empty values in the 'genre' column
DELETE FROM
    book_genres
WHERE
    genre IS NULL
    OR genre = '';














