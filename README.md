# Netflix Data Pipeline using DBT, Snowflake, and AWS S3

This is an **end-to-end cloud-based data engineering and analytics project** that demonstrates the modern ELT (Extract-Load-Transform) pipeline using popular cloud tools: **Amazon S3** for data storage, **Snowflake** as the data warehouse, and **DBT (Data Build Tool)** for data transformation, testing, documentation, and orchestration.

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](https://github.com/bISTP/netflix-snowflake-dbt/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![dbt-core](https://img.shields.io/badge/dbt--core-1.10.11-orange.svg)](https://github.com/dbt-labs/dbt-core)
[![dbt-snowflake](https://img.shields.io/badge/dbt--snowflake-1.10.2-blue.svg)](https://github.com/dbt-labs/dbt-snowflake)
[![dbt-utils](https://img.shields.io/badge/dbt--utils-1.3.1-informational.svg)](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/)
[![Code Coverage](https://img.shields.io/badge/coverage-90%25-brightgreen)](https://github.com/bISTP/netflix-snowflake-dbt/actions)

---

## Project Overview

In this project, we leverage the MovieLens dataset (a Netflix-like movie ratings dataset) to showcase how to build a scalable and maintainable data analytics platform using the modern data stack.

- **Data Extraction & Storage**: MovieLens CSV files are uploaded to Amazon S3 (a cloud object storage).
- **Data Loading**: Raw data files are loaded from S3 into Snowflake’s raw landing zone using Snowflake's COPY command.
- **Data Transformation**: DBT is used extensively to:
  - Create modular SQL models for staging raw data.
  - Build dimensional models (fact and dimension tables).
  - Implement slowly changing dimensions (SCD Type 2) via DBT snapshots.
  - Apply testing and validation on data models.
  - Generate automated documentation and lineage graphs.
- **Serving Layer**: Transformed data models are available in Snowflake for analytics and can be connected to BI tools like Looker Studio, PowerBI, or Tableau.

---

## Dataset: MovieLens 20M

This project utilizes the MovieLens 20M dataset, a popular and stable benchmark dataset for analytics and recommendation systems.

*   **Description:** The dataset contains 20 million ratings and 465,000 tag applications applied to 27,000 movies by 138,000 users. It also includes a "tag genome" with 12 million relevance scores across 1,100 tags, providing rich data for in-depth analysis.
*   **Source:** [GroupLens Website](https://grouplens.org/datasets/movielens/20m/)
*   **Files Used:** `movies.csv`, `ratings.csv`, `tags.csv`, `links.csv`, `genome-scores.csv`, `genome-tags.csv`.

---

## Key Features

- **Cloud-native architecture** leveraging AWS S3 and Snowflake.
- **ELT paradigm**: Data is first Extracted and Loaded into Snowflake, then Transformed using DBT.
- **Modular and version-controlled transformations** using DBT models, snapshots, macros, and tests.
- **Data quality assurance** with built-in and custom DBT tests.
- **Automated documentation and lineage visualization** using DBT docs.
- **Support for incremental loading and SCD Type 2 for dimensional modeling**.
- **Use of DBT packages** for reusable macros and utilities.
- **Clear separation of raw, staging, development, and snapshot schemas** in Snowflake.

---

## Architecture and Lineage Graph

> **Architecure Diagram**
>![Architecure Diagram](/assets/images/architecture.png)

> **Lineage Graph**
>![Lineage Graph](/assets/images/dbt-dag.png)

---

## Tech Stack

| Area | Tool | Version |
|---|---|---|
| Cloud Storage | AWS S3 | N/A |
| Data Warehouse | Snowflake | N/A |
| Data Transformation | dbt-core | 1.10.11 |
| dbt Adapter | dbt-snowflake | 1.10.2 |
| dbt Package | dbt-utils | 1.3.1 |
| Language | SQL | N/A |
| Language | Python | 3.12.8 |

---

## Prerequisites

- AWS account with access to S3.
- Snowflake account (30-day free trial available).
- Basic knowledge of SQL and data warehousing concepts.
- Python environment with DBT core installed and configured.
- Familiarity with version control (Git/GitHub).

---

## Project Structure

```
netflix-dbt-project/
│
├── analysis/                  # Ad-hoc or exploratory analysis queries (not materialized).
│   └── movie_analysis.sql     
│
├── macros/                    # Custom macros (functions) to encapsulate reusable SQL logic.
│   └── no_null_columns.sql
│
├── models/                    # Core dbt models organized in a layered architecture.
│   │
│   ├── staging/               # Staging models that mirror raw data with light transformations
│   │   ├── src_movies.sql
│   │   ├── src_ratings.sql
│   │   ├── src_tags.sql
│   │   ├── src_links.sql
│   │   ├── src_genome_tags.sql
│   │   └── src_genome_scores.sql
│   │
│   ├── dim/                   # Dimension tables with business logic and transformations
│   │   ├── dim_movies.sql
│   │   ├── dim_users.sql
│   │   ├── dim_genome_tags.sql
│   │   └── dim_movies_with_tags.sql # Ephemeral model
│   │
│   ├── fct/                   # Fact tables - represent events or metrics
│   │   ├── fct_genome_scores.sql
│   │   └── fct_ratings.sql
│   │
│   ├── marts/                 # Final aggregated or specialized models for analysis
│   │   └── mart_movie_releases.sql
│   │
│   ├── schema.yml             # Configuration, documentation, and tests for all models.
│   └── sources.sql            # Definitions and tests for raw data sources.
│
├── seeds/                     # Static CSV files loaded as tables
│   └── movie_release_dates.csv
│
├── snapshots/                 # DBT snapshots for SCD Type 2 implementation
│   └── snap_tags.sql
│
├── tests/                     # Custom, complex data tests (singular tests).
│        ├── no_nulls_in_columns_test.sql
│        └── relevance_score_test.sql
│
├── .sqlfluff                  # Configuration rules for the SQLFluff linter.
├── dbt_project.yml            # DBT project configuration file
├── packages.yml               # DBT packages dependencies file
├── README.md                  # Project documentation (this file).
├── requirements.txt           # Python dependencies for dbt (required)
└── requirements-dev.txt       # Python dependencies for sqlfluff (optional - if using sqlfluff)
```

---

## Getting Started

1. **Set up AWS S3 Bucket**  
   Create an S3 bucket and upload MovieLens dataset CSV files.

2. **Snowflake Setup**  
   - Create Snowflake account and configure roles, warehouses, database, and schemas (`raw`, `staging`, `dev`, `snapshot`).
   - Create Snowflake stages and storage integrations to connect to S3.
   - Load raw data from S3 into Snowflake raw schemas using the COPY command.

3. **DBT Environment Setup**  
   - Install Python and create a virtual environment.
   - Install `dbt-core` and `dbt-snowflake` adapter manually or `pip install -r requirements.txt` ( If you are using `sqlfluff` [Click Here](#code-quality--linting-with-sqlfluff) )
   - Initialize DBT project (`dbt init netflix`).
   - Configure `profiles.yml` with Snowflake connection details.

4. **Build DBT Models**  
   - Create staging models that lightly transform raw data.
   - Design dimension and fact models.
   - Implement snapshots for SCD Type 2 slowly changing dimensions.
   - Define seeds for static lookup tables.
   - Add tests for data quality.
   - Use macros for reusable SQL snippets.

5. **Run & Test DBT Models**  
   - Use `dbt run` to build models.
   - Use `dbt test` to validate data quality.
   - Use `dbt snapshot` to maintain history on mutable tables.

6. **Generate Documentation**  
   - Run `dbt docs generate` and `dbt docs serve` to view full project documentation and lineage graph.

7. **Analysis & Visualization**  
   - Use the final transformed tables to build dashboards in BI tools like Looker Studio, Tableau, or PowerBI.

---

## Code Quality & Linting with SQLFluff

To ensure code consistency, readability, and adherence to best practices, this project uses [SQLFluff](https://sqlfluff.com/), a powerful SQL linter and auto-formatter. It is configured to work seamlessly with the dbt templater.

This setup replaces the need for other formatters like `dbt-formatter`.

### Setup Instructions

If you wish to use the linter and formatter as configured in this project, follow these steps after setting up your initial virtual environment:

1.  **Install Development Dependencies:**
    The required packages are listed in `requirements-dev.txt`. Install them using pip:
    ```bash
    pip install -r requirements-dev.txt
    ```
    Note: You don't have to `pip install -r requirements.txt` after this.

2.  **VS Code Integration (Recommended):**
    A  pre-configured VS Code settings file is provided below, save it at `.vscode/settings.json`. To use it, simply install the official [SQLFluff extension](https://marketplace.visualstudio.com/items?itemName=sqlfluff.sqlfluff) from the VS Code Marketplace. The extension will automatically detect the settings and the project's `.sqlfluff` configuration file.

`.vscode/settings.json`
```json
{
  // =====================================================================
  // FILE ASSOCIATIONS FOR DBT
  // =====================================================================
  "files.associations": {
    // Tell VS Code to treat .sql files in these dbt folders as Jinja-SQL
    "**/models/**/*.sql": "jinja-sql",
    "**/analysis/**/*.sql": "jinja-sql",
    "**/seeds/**/*.sql": "jinja-sql", // Though seeds are csv, some use sql headers
    "**/snapshots/**/*.sql": "jinja-sql",
    "**/macros/**/*.sql": "jinja-sql",
    // Associate .yml files with the YAML language for proper validation
    "**/*.yml": "yaml",
    "dbt_project.yml": "yaml"
  },

  // =====================================================================
  // SQLFLUFF CONFIGURATION (LINTER + FORMATTER)
  // =====================================================================
  // 1. TURN OFF FORMAT ON SAVE for SQL files. This is the most important step to prevent data loss.
  // We keep it true globally but will override it for SQL.
  "[jinja-sql]": {
      "editor.defaultFormatter": "dorzey.vscode-sqlfluff"
  },
  // Set Prettier as formatter for YAML files for consistency
  "[yaml]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  // --- SQLFluff Settings ---
  // Tell the extension which dialect to use (it will infer from dbt_project.yml)
  "sqlfluff.dialect": "snowflake",

// DBT setup requires these settings to lint and format the document.
  // Enable linting and formatting
  "sqlfluff.linter.run": "onSave",
  // Execute formatting in the terminal to ensure it uses the correct environment
  "sqlfluff.experimental.format.executeInTerminal": true,
  // Disable format on save to prevent overwriting files unexpectedly
  "editor.formatOnSave": false,
  // =====================================================================
  // PYTHON & TERMINAL SETTINGS FOR THIS DBT PROJECT
  // =====================================================================
  // This helps dbt Power User and sqlfluff find your dbt executable
  // Replace with the path to the python.exe inside your dbt virtual environment
  // Example for .venv folder: "python.pythonPath": "${workspaceFolder}/.venv/bin/python"
  // Example for Windows: "python.pythonPath": "${workspaceFolder}\\.venv\\Scripts\\python.exe"
  // It's often better to let VS Code's Python extension handle this by selecting the
  // interpreter from the status bar, but this is a good explicit override.
  "python.defaultInterpreterPath": "${workspaceFolder}\\.venv\\Scripts\\python.exe",

  // THE DEFINITIVE FIX: Explicitly tell the SQLFluff extension where to find the tool.
  "sqlfluff.executablePath": "${workspaceFolder}\\.venv\\Scripts\\sqlfluff.EXE", // or you can put your full path instead of ${workspaceFolder} variable

  "sqlfluff.workingDirectory": "${workspaceFolder}",

  // CRITICAL: Ensure the working directory is NOT set.
  // If you have "sqlfluff.workingDirectory" in your settings, REMOVE IT or set it to null.
  // This allows SQLFluff to run from your project root, find dbt_project.yml, and work correctly.

  "python-envs.pythonProjects": [],
  "dbt.enableNewLineagePanel": true // Adjust path as needed!
}
```

### Usage

Once set up, you can lint and format your code from the command line:

*   **To check for linting errors:**
    ```bash
    sqlfluff lint models/
    ```
*   **To automatically fix errors:**
    ```bash
    sqlfluff fix models/
    ```


---

## Additional Notes

- This project follows the **ELT** approach, where data is first loaded in raw form and transformed afterwards in the warehouse using DBT.
- DBT encapsulates transformation logic in modular SQL models, enabling version control, testing, and documentation.
- The project emphasizes **best practices** like separating raw, staging, dev, and snapshot schemas to ensure data integrity.
- Advanced DBT features such as incremental models, ephemeral models, macros, and packages are utilized.
- The project is designed to be **cloud-native and scalable**, suitable for real-world enterprise use.

---

## References

- [DBT Documentation](https://docs.getdbt.com/)
- [Snowflake Documentation](https://docs.snowflake.com/)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- MovieLens Dataset: https://grouplens.org/datasets/movielens/20m/

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## Acknowledgements

A special thank you to [Darshil Parmar](https://www.youtube.com/@DarshilParmar) for creating such a valuable and comprehensive resource for the data community.

---
