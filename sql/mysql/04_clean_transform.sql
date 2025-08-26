USE nike_bi;

-- Example cleanups and helpful views
-- Normalize region if null using lookup (re-check join)
UPDATE fct_nike_factories f
LEFT JOIN dim_country d ON f.Country = d.Country
SET f.Region = COALESCE(f.Region, d.Region);

-- Example KPI view
DROP VIEW IF EXISTS vw_country_summary;
CREATE VIEW vw_country_summary AS
SELECT
  Country,
  Region,
  COUNT(*) AS FactoryCount
FROM fct_nike_factories
GROUP BY Country, Region;
