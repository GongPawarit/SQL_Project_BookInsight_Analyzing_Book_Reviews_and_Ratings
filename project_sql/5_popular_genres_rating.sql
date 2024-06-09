WITH merged_data AS (
    SELECT 
        bd.book_id,
        bd.book_title,
        bd.average_rating,
        bg.genre
    FROM 
        book_details AS bd
    JOIN 
        book_genres AS bg
    ON 
        bd.book_id = bg.book_id
),
top_genres AS (
    SELECT 
        genre,
        COUNT(*) AS book_count
    FROM 
        merged_data
    GROUP BY 
        genre
    ORDER BY 
        book_count DESC
    LIMIT 10
)
SELECT 
    tg.genre,
    ROUND(AVG(md.average_rating),2) AS avg_rating
FROM 
    top_genres AS tg
JOIN 
    merged_data AS md
ON 
    tg.genre = md.genre
GROUP BY 
    tg.genre
ORDER BY 
    avg_rating DESC;
