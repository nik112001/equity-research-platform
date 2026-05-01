# Learnings

A running log of concepts, gotchas, and insights discovered while building this platform. Updated as the project progresses — each day's learnings go in their own section.

## Day 1

- .gitigore stores files that are unnecessary for version control like pycache
    for run time and egg-info used for packaging 

- pyarrow — Apache Arrow Python bindings. Needed for efficient pandas-to-Spark conversion and for reading/writing Parquet locally.

- The mental model: a "bundle" is a unit of deployment. You declare your jobs, pipelines, notebooks, ML experiments, etc. in YAML, then databricks bundle deploy pushes them all up. It's infrastructure-as-code for Databricks resources.( kind of like docker compose down)

- Project structure matters: `notebooks/` is for orchestration on Databricks, `src/` is for testable Python logic. Keeping them separate makes code reusable across notebooks and unit-testable with pytest.
- `pyproject.toml` is the modern Python project manifest (PEP 621). It replaces `setup.py` and configures all your tools (ruff, black, pytest) in one place. We still keep `requirements.txt` because Databricks clusters install from it.
- Databricks Asset Bundles use `databricks.yml` as infra-as-code for the workspace — pipelines, jobs, and clusters are declared in YAML, then `databricks bundle deploy` ships them. `mode: development` prefixes resource names with my username so dev resources don't collide with prod.

## Day 2

- Medallion architecture: three layers because each serves different consumers. Bronze = raw replay log (never delete), silver = trusted version of truth (dedup'd, typed), gold = purpose-built per consumer. Silver is generic; gold is bespoke.
- Unity Catalog is `catalog.schema.table` — a 3-level namespace with permissions, lineage, and audit logs at every level. Volumes (`catalog.schema.volume`) are how we govern non-tabular files like raw SEC HTML.
- SHOW lists objects, DESCRIBE shows details on one object, EXTENDED adds metadata. Worth committing to muscle memory for debugging.
- learning that functions that can be called N amount of times and result ion the same action is called idempotency
- DDL = Data Definition Language(create destroy alter objects liek tables,schemas,catologs) DML = Data Manipulation Language(read,write,change rows in tables)