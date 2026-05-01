-- =============================================================================
-- Purpose:  Idempotent setup of the equity_research Unity Catalog — schemas,
--           volume, and grants.
--
-- Assumptions:
--   - The catalog `equity_research` already exists (created once via the
--     Databricks UI under Data > Catalogs > Create Catalog).
--   - The user running this script has CREATE SCHEMA and CREATE VOLUME
--     privileges on the catalog.
--
-- How to run:
--   Option A — Databricks SQL Editor: open a SQL editor cell, paste the
--              entire file, and click Run. Safe to run multiple times.
--   All statements use IF NOT EXISTS, so re-running is fully idempotent.
-- =============================================================================


-- ---------------------------------------------------------------------------
-- Schemas (medallion layers)
-- ---------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS equity_research.bronze
  COMMENT 'Raw, append-only data as ingested from external sources.';

CREATE SCHEMA IF NOT EXISTS equity_research.silver
  COMMENT 'Cleaned, deduplicated, strictly-typed business data.';

CREATE SCHEMA IF NOT EXISTS equity_research.gold
  COMMENT 'Purpose-built marts for BI, agents, and ML consumption.';


-- ---------------------------------------------------------------------------
-- Volume — raw SEC filing storage
-- ---------------------------------------------------------------------------

CREATE VOLUME IF NOT EXISTS equity_research.bronze.raw_filings
  COMMENT 'Raw HTML/JSON of SEC filings before parsing.';


-- ---------------------------------------------------------------------------
-- Grants (commented out — uncomment once you have a group configured)
--
-- On the Databricks Free Edition, group management is limited and you may
-- not be able to create or assign groups yet. You can safely skip this
-- section and run the DDL above without grants for now. When you are ready,
-- create a group in the Databricks account console, then uncomment and run
-- the statements below.
-- ---------------------------------------------------------------------------

-- GRANT USAGE ON CATALOG equity_research TO `account users`;
-- GRANT USAGE ON SCHEMA equity_research.silver TO `account users`;
-- GRANT SELECT ON SCHEMA equity_research.silver TO `account users`;


-- ---------------------------------------------------------------------------
-- Verification queries — run these to confirm the setup looks correct
-- ---------------------------------------------------------------------------

-- Lists all schemas in the catalog; you should see bronze, silver, and gold.
SHOW SCHEMAS IN equity_research;

-- Lists all volumes in the bronze schema; you should see raw_filings.
SHOW VOLUMES IN equity_research.bronze;

-- Displays catalog-level metadata including owner and storage root.
DESCRIBE CATALOG equity_research;
