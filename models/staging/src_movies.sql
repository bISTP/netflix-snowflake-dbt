WITH raw_movies AS (
    SELECT * FROM {{ source('netflix_snowflake', 'r_movies') }}
)

SELECT
    movieid AS movie_id,
    title,
    genres
FROM raw_movies
