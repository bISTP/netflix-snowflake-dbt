WITH raw_genome_tags AS (
    SELECT * FROM {{ source('netflix_snowflake', 'r_genome_tags') }}
)

SELECT
    tagid AS tag_id,
    tag
FROM raw_genome_tags
