
--  to fix the data types for analysis
ALTER TABLE global_climate_events 
ALTER COLUMN severity TYPE NUMERIC,
ALTER COLUMN economic_impact_million_usd TYPE NUMERIC,
ALTER COLUMN infrastructure_damage_score TYPE NUMERIC,
ALTER COLUMN international_aid_million_usd TYPE NUMERIC;