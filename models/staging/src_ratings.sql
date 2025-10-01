WITH raw_ratings AS (
    SELECT * FROM {{ source('netflix_snowflake', 'r_ratings') }}
)

SELECT
    userid AS user_id,
    movieid AS movie_id,
    rating,
    TO_TIMESTAMP_LTZ(timestamp) AS rating_timestamp
FROM
    raw_ratings
