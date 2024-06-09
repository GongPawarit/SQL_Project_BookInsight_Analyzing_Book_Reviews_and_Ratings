# Introduction
In the digital age, books have expanded into vast online repositories with millions of reviews and ratings. SQL_Project_BookInsight_Analyzing_Book_Reviews_and_Ratings leverages SQL to process, analyze, and visualize this data, uncovering patterns and trends in literary preferences, author popularity, and genre insights.

SQL query? Check them out here: [project_sql folder](/project_sql/)

# Background
In the digital age, understanding reader preferences and trends in the book industry is crucial. This project, **SQL_Project_BookInsight_Analyzing_Book_Reviews_and_Ratings**, was initiated to explore the vast amount of data generated from book reviews and ratings, aiming to uncover insights into author popularity, genre preferences, and top-rated books.

The data used in this project comes from [kaggle: Goodreads-books](https://www.kaggle.com/datasets/jealousleopard/goodreadsbooks). It includes information on authors, book titles, genres, and user ratings.

### The key questions addressed through SQL queries in this project are:

1. Who are the most published authors?
2. Which books have the highest ratings?
3. Who are the authors with the highest average ratings?
4. What are the genre statistics for top-rated authors?
5. Which genres are the most popular and highly rated?

# Tools I Used

For my deep dive into the world of book reviews and ratings, I utilized several key tools:

- **SQL:** The core tool for querying the database, enabling detailed analysis of book data.
- **PostgreSQL:** The database management system used to store and manage the extensive book review and rating data.
- **Visual Studio Code:** My primary environment for database management and executing SQL queries.
- **Git & GitHub:** Crucial for version control and sharing my SQL scripts and analysis, facilitating collaboration and project tracking.

# The Analysis
### 1. Who are the most published authors?
To identify the most prolific authors, I filtered the dataset to list authors by the number of books published. This query highlights the top authors with the highest number of publications.

```sql
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
```

Here's the breakdown of the most published authors:
- **Most Published Author:**
    - **Stephen King**, with a total of 74 books.
- **Common Authors and Number of Books Published:**
    - **Danielle Steel** follows with 47 books.
    - **Agatha Christie** and **Sylvia Browne** have published 45 and 43 books respectively.
- **Frequent Authors:**
    - Authors like **Stephen King**, **Danielle Steel**, and **Agatha Christie** have consistently published a large number of books, highlighting their prolific writing careers.

![Most Published Authors](/assets/1_top_10_most_published_authors.png)
### 2. Which books have the highest ratings?
### 3. Who are the authors with the highest average ratings?
### 4. What are the genre statistics for top-rated authors?
### 5. Which genres are the most popular and highly rated?