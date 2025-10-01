WITH raw_genome_scores AS (
    SELECT * FROM {{ source('netflix_snowflake', 'r_genome_scores') }}
)

SELECT
    movieid AS movie_id,
    tagid AS tag_id,
    relevance
FROM raw_genome_scores
