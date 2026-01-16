
-- CHECK 1: Identify NULLs in Critical Columns
-- Ensures we aren't missing data that would break our sums/averages.
SELECT 
    COUNT(*) - COUNT(country) AS missing_countries,
    COUNT(*) - COUNT(year) AS missing_years,
    COUNT(*) - COUNT(economic_impact_million_usd) AS missing_impact_data,
    COUNT(*) - COUNT(severity) AS missing_severity
FROM global_climate_events;

-- CHECK 2: Range Validation for Numeric Columns
-- Ensures no "impossible" values (like negative deaths or severity > 10).
SELECT 
    MIN(year) AS earliest_year, 
    MAX(year) AS latest_year,
    MIN(severity) AS min_severity, 
    MAX(severity) AS max_severity,
    MIN(economic_impact_million_usd) AS min_damage
FROM global_climate_events;

-- CHECK 3: Data Type & Formatting Verification
-- Verifies that 'year' and 'month' are stored as integers for proper time-series analysis.
SELECT 
    column_name, 
    data_type 
FROM information_schema.columns 
WHERE table_name = 'global_climate_events' 
AND column_name IN ('year', 'month', 'economic_impact_million_usd', 'deaths');

-- CHECK 4: Detecting Duplicate Records
-- Ensures the same event wasn't imported twice.
SELECT event_id, COUNT(*)
FROM global_climate_events
GROUP BY event_id
HAVING COUNT(*) > 1;