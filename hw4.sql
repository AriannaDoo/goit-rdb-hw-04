USE LibraryManagement;

SELECT 'authors' AS table_name, COUNT(*) AS rows_count FROM authors
UNION ALL
SELECT 'genres', COUNT(*) FROM genres
UNION ALL
SELECT 'books', COUNT(*) FROM books
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'borrowed_books', COUNT(*) FROM borrowed_books;