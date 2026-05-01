# equity-research-platform

An end-to-end equity research platform built on Databricks, combining Delta Live Tables for medallion-architecture data pipelines, Power BI for reporting, and Mosaic AI agents for natural-language research workflows. Ingests market data, filings, and news; transforms them through bronze → silver → gold layers; and surfaces insights via dashboards and AI-assisted analysis.

**Status:** in development

## Setup

### Unity Catalog

Bootstrap the catalog in two steps:

1. **Create the catalog** (one time, via UI): in your Databricks workspace open **Data > Catalogs > Create Catalog**, name it `equity_research`, and choose a storage location.

2. **Run the setup script**: open a Databricks SQL editor, paste the contents of [`sql/00_setup_catalog.sql`](sql/00_setup_catalog.sql), and click **Run**. The script creates the `bronze`, `silver`, and `gold` schemas and the `bronze.raw_filings` volume. It is fully idempotent — safe to run multiple times with no side effects.

## Stack

- **Databricks** — unified compute, DLT pipelines, Unity Catalog
- **Delta Live Tables** — declarative pipeline orchestration
- **Delta Lake / Unity Catalog** — governed lakehouse storage
- **yfinance / requests / BeautifulSoup4** — market data & web ingestion
- **Power BI** — dashboards and reports (`powerbi/`)
- **Mosaic AI Agents** — LLM-powered research agents (`agents/`, `genie/`)
- **Databricks Asset Bundles** — IaC deployment via `databricks.yml`

## Repo structure

```
equity-research-platform/
├── notebooks/
│   ├── bronze/     # Raw ingestion notebooks
│   ├── silver/     # Cleaning and conforming
│   ├── gold/       # Business-level aggregations
│   └── ml/         # Feature engineering and model notebooks
├── src/
│   └── equity_research/   # Installable Python package (shared utils)
├── pipelines/      # DLT pipeline definitions
├── sql/            # Ad-hoc and scheduled SQL queries
├── tests/          # pytest unit and integration tests
├── resources/      # Databricks job / cluster YAML definitions
├── powerbi/        # Power BI report files and templates
├── genie/          # Genie space configurations
└── agents/         # Mosaic AI agent definitions
```
