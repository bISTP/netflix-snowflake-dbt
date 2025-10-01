{{
    config(
    materialized = 'table',
    )
}}

WITH fct_ratings AS (
    SELECT * FROM {{ ref("fct_ratings") }}
),

seed_dates AS (
    SELECT * FROM {{ ref("seed_movie_release_dates") }}
)

SELECT
    f.*,
    CASE
        WHEN s.release_date IS NULL THEN 'unknown'
        ELSE 'known'
    END AS release_info_available
FROM fct_ratings AS f
LEFT JOIN seed_dates AS s ON f.movie_id = s.movie_id
