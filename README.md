# Other SAR – Regional Scorecard

This repository includes lightweight Stata utilities to build regional and national indicator tables for the SAR Scorecard. Use these scripts to generate a clean template, populate it with sub-national data, and standardize/format the final indicator outputs for analysis and reporting.

## Scripts

- **subnat_template.do**  
  Creates a blank, well-labeled template (variables, types, and minimal metadata) for regional/national scorecard indicators. Run this first to scaffold the expected structure.

- **subnat_populate.do**  
  Ingests source datasets and fills the template with sub-national observations (e.g., state/province) and national totals. Handles basic joins/keys and minimal data hygiene to ensure consistent coverage across geographies and years.

- **subnat_indicator_format.do**  
  Final pass that standardizes names, units, and display formats (e.g., percent vs. number), applies rounding, and outputs tidy tables ready for dashboards or publication.

## Typical flow

1) `subnat_template.do` → 2) `subnat_populate.do` → 3) `subnat_indicator_format.do`

> Result: a clean, consistent indicator table that can be compared across countries and aggregated to regional totals.
