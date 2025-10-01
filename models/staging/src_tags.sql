WITH raw_tags AS (
    SELECT * FROM {{ source('netflix_snowflake', 'r_tags') }}
)

SELECT
    userid AS user_id,
    movieid AS movie_id,
    tag,
    TO_TIMESTAMP_LTZ(timestamp) AS tag_timestamp
FROM raw_tags
