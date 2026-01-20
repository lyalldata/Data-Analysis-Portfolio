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


-- 2. THE TOP 15 "AID GAP" ANALYSIS
-- Identifies the 15 most damaged countries and calculates their aid-to-damage ratio.
WITH TargetCountries AS (
    SELECT country
    FROM global_climate_events
    GROUP BY country
    ORDER BY SUM(economic_impact_million_usd) DESC
    LIMIT 15
),
FinancialMetrics AS (
    SELECT 
        country,
        year,
        SUM(economic_impact_million_usd) AS total_damage,
        SUM(international_aid_million_usd) AS total_aid
    FROM global_climate_events
    WHERE country IN (SELECT country FROM TargetCountries)
    GROUP BY country, year
)
SELECT 
    country,
    year,
    total_damage,
    total_aid,
    CAST(ROUND((total_aid / NULLIF(total_damage, 0)) * 100, 2) AS NUMERIC) AS aid_coverage_pct
FROM FinancialMetrics
ORDER BY total_damage DESC;


-- 3. SURVIVABILITY & RESPONSE EFFICIENCY
-- Categorizes response windows and calculates average mortality rates.
WITH ResponseWindows AS (
    SELECT 
        year,
        deaths,
        injuries,
        CASE 
            WHEN response_time_hours <= 12 THEN 'Critical (<12h)'
            WHEN response_time_hours <= 48 THEN 'Standard (12-48h)'
            ELSE 'Delayed (>48h)'
        END AS response_category
    FROM global_climate_events
)
SELECT 
    response_category,
    COUNT(*) AS sample_size,
    CAST(ROUND(AVG(deaths), 2) AS NUMERIC) AS avg_deaths,
    CAST(ROUND(AVG(injuries), 2) AS NUMERIC) AS avg_injuries
FROM ResponseWindows
GROUP BY response_category
ORDER BY avg_deaths ASC;


-- 4. YEAR-OVER-YEAR (YoY) TREND ANALYSIS
-- Uses Window Functions inside a CTE to track disaster acceleration.
WITH YearlyStats AS (
    SELECT 
        year, 
        COUNT(*) AS event_count,
        SUM(deaths) AS yearly_deaths
    FROM global_climate_events
    GROUP BY year
)
SELECT 
    year,
    event_count,
    LAG(event_count) OVER (ORDER BY year) AS prev_year_count,
    (event_count - LAG(event_count) OVER (ORDER BY year)) AS frequency_change,
    CAST(ROUND(AVG(event_count) OVER (ORDER BY year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1) AS NUMERIC) AS rolling_3yr_avg
FROM YearlyStats
ORDER BY year DESC;


-- 5. LETHALITY VS. INFRASTRUCTURE VULNERABILITY
-- Ranks event types by human cost while comparing to physical infrastructure damage.
WITH EventImpacts AS (
    SELECT 
        event_type,
        SUM(deaths) AS total_deaths,
        SUM(affected_population) AS total_affected,
        AVG(severity) AS avg_severity,
        AVG(infrastructure_damage_score) AS avg_infra_score,
        AVG(economic_impact_million_usd) AS avg_econ_impact
    FROM global_climate_events
    GROUP BY event_type
)
SELECT 
    event_type,
    total_deaths,
    CAST(ROUND(avg_severity, 2) AS NUMERIC) AS severity_index,
    CAST(ROUND(avg_infra_score, 2) AS NUMERIC) AS infra_risk_score,
    CAST(ROUND(avg_econ_impact, 2) AS NUMERIC) AS econ_risk_score
FROM EventImpacts
ORDER BY total_deaths DESC;


-- 6. DISASTER FREQUENCY MATRIX (TRANSPOSE PREP)
-- Final view for Tableau: Top 15 countries as rows, year as column data.
WITH Top15List AS (
    SELECT country
    FROM global_climate_events
    GROUP BY country
    ORDER BY SUM(economic_impact_million_usd) DESC
    LIMIT 15
)
SELECT 
    country, 
    year, 
    COUNT(*) AS total_annual_events,
    CAST(ROUND(SUM(economic_impact_million_usd), 2) AS NUMERIC) AS annual_damage_usd
FROM global_climate_events
WHERE country IN (SELECT country FROM Top15List)
GROUP BY country, year
ORDER BY country ASC, year DESC;


-- 7. THE RESOURCE EFFICIENCY INDEX (REI)
-- Does faster response and higher aid correlate with lower mortality? 
-- This helps recruiters see you can analyze ROI (Return on Investment).
WITH EfficiencyMetrics AS (
    SELECT 
        country,
        AVG(response_time_hours) AS avg_response_hrs,
        SUM(international_aid_million_usd) AS total_aid,
        SUM(deaths) AS total_deaths,
        COUNT(*) AS event_count
    FROM global_climate_events
    GROUP BY country
    HAVING COUNT(*) > 5 -- Focus on countries with enough data for a trend
)
SELECT 
    country,
    CAST(ROUND(avg_response_hrs, 1) AS NUMERIC) AS response_efficiency,
    CAST(ROUND(total_aid / NULLIF(total_deaths, 0), 2) AS NUMERIC) AS aid_per_life_saved,
    CASE 
        WHEN avg_response_hrs < 24 AND total_deaths < 500 THEN 'High Efficiency'
        WHEN avg_response_hrs BETWEEN 24 AND 48 THEN 'Moderate Efficiency'
        ELSE 'Resource Constrained'
    END AS operational_status
FROM EfficiencyMetrics
ORDER BY avg_response_hrs ASC;

-- 8. THE GLOBAL CLIMATE RISK SCORECARD (CONCLUSION)
-- Combines yearly death trends (2020-2025), economic impact, and human loss into a weighted index.
WITH GlobalAverages AS (
    SELECT 
        AVG(economic_impact_million_usd) AS avg_global_damage,
        AVG(deaths) AS avg_global_deaths
    FROM global_climate_events
),
RiskCalculation AS (
    SELECT 
        country,
        -- Yearly Death Breakdown (2020-2025)
        SUM(deaths) FILTER (WHERE year = 2020) AS deaths_2020,
        SUM(deaths) FILTER (WHERE year = 2021) AS deaths_2021,
        SUM(deaths) FILTER (WHERE year = 2022) AS deaths_2022,
        SUM(deaths) FILTER (WHERE year = 2023) AS deaths_2023,
        SUM(deaths) FILTER (WHERE year = 2024) AS deaths_2024,
        SUM(deaths) FILTER (WHERE year = 2025) AS deaths_2025,
        SUM(deaths) AS total_deaths,
        SUM(economic_impact_million_usd) AS total_damage,
        -- Weighted Score: 60% Economic, 40% Human Loss
        ((SUM(economic_impact_million_usd) / (SELECT avg_global_damage FROM GlobalAverages)) * 0.6) + 
        ((SUM(deaths) / (SELECT avg_global_deaths FROM GlobalAverages)) * 0.4) AS raw_risk_score
    FROM global_climate_events
    GROUP BY country
)
SELECT 
    country,
    COALESCE(deaths_2020, 0) AS deaths_2020,
    COALESCE(deaths_2021, 0) AS deaths_2021,
    COALESCE(deaths_2022, 0) AS deaths_2022,
    COALESCE(deaths_2023, 0) AS deaths_2023,
    COALESCE(deaths_2024, 0) AS deaths_2024,
    COALESCE(deaths_2025, 0) AS deaths_2025,
    total_deaths,
    CAST(ROUND(total_damage, 2) AS NUMERIC) AS total_damage_usd,
    CAST(ROUND(raw_risk_score, 2) AS NUMERIC) AS climate_vulnerability_index,
    RANK() OVER (ORDER BY raw_risk_score DESC) AS global_risk_rank
FROM RiskCalculation
ORDER BY global_risk_rank ASC
LIMIT 20;