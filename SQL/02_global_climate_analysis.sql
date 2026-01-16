-- 1. SEASONAL RISK & FATALITY MATRIX
-- Uses a CTE to calculate monthly statistics before identifying the deadliest 'Hot Zones'.
WITH MonthlyAggregates AS (
    SELECT 
        country, 
        month, 
        year,
        COUNT(*) AS event_frequency,
        SUM(deaths) AS total_fatalities,
        AVG(severity) AS avg_severity
    FROM global_climate_events
    GROUP BY country, month, year
)
SELECT *
FROM MonthlyAggregates
WHERE total_fatalities > 0
ORDER BY total_fatalities DESC
LIMIT 20;
