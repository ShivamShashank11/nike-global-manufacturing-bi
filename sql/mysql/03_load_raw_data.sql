USE nike_bi;

-- 1) Load staging from CSV (Windows: prefer LOCAL INFILE)
-- Make sure MySQL allows LOCAL INFILE (see note below)
LOAD DATA LOCAL INFILE "E:/nike-global-manufacturing-bi/data/raw/nike_global_factories.csv"
INTO TABLE stg_nike_factories
CHARACTER SET utf8mb4
FIELDS TERMINATED BY "," ENCLOSED BY "\"" 
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(@FactoryName,@FactoryType,@ProductType,@NikeBrands,@SupplierGroup,@City,@StateProv,@PostalCode,@CountryRegionRaw,@RegionRaw)
SET
 FactoryName      = NULLIF(@FactoryName,''),
 FactoryType      = NULLIF(@FactoryType,''),
 ProductType      = NULLIF(@ProductType,''),
 NikeBrands       = NULLIF(@NikeBrands,''),
 SupplierGroup    = NULLIF(@SupplierGroup,''),
 City             = NULLIF(@City,''),
 StateProv        = NULLIF(@StateProv,''),
 PostalCode       = NULLIF(@PostalCode,''),
 CountryRegionRaw = NULLIF(@CountryRegionRaw,''),
 RegionRaw        = NULLIF(@RegionRaw,'');

-- 2) Load dim_country from lookup csv
LOAD DATA LOCAL INFILE "E:/nike-global-manufacturing-bi/data/lookup/country_region_mapping.csv"
INTO TABLE dim_country
CHARACTER SET utf8mb4
FIELDS TERMINATED BY "," ENCLOSED BY "\"" 
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(Country, Region);

-- 3) Populate fact table (clean)
INSERT INTO fct_nike_factories
(FactoryName,FactoryType,ProductType,NikeBrands,SupplierGroup,City,StateProv,PostalCode,Country,Region,CountryKey)
SELECT
  TRIM(FactoryName),
  TRIM(FactoryType),
  TRIM(ProductType),
  TRIM(NikeBrands),
  TRIM(SupplierGroup),
  TRIM(City),
  TRIM(StateProv),
  TRIM(PostalCode),
  TRIM(CountryRegionRaw)     AS Country,
  TRIM(RegionRaw)            AS Region,
  dc.CountryKey
FROM stg_nike_factories s
LEFT JOIN dim_country dc
  ON TRIM(s.CountryRegionRaw) = dc.Country;

-- Optional sanity indexes
CREATE INDEX ix_fct_country ON fct_nike_factories (Country);
CREATE INDEX ix_fct_region  ON fct_nike_factories (Region);
