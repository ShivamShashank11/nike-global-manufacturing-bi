USE nike_bi;

-- Staging table exactly matching CSV columns
DROP TABLE IF EXISTS stg_nike_factories;
CREATE TABLE stg_nike_factories (
  FactoryName            VARCHAR(255),
  FactoryType            VARCHAR(150),
  ProductType            VARCHAR(150),
  NikeBrands             VARCHAR(255),
  SupplierGroup          VARCHAR(255),
  City                   VARCHAR(150),
  StateProv              VARCHAR(150),
  PostalCode             VARCHAR(60),
  CountryRegionRaw       VARCHAR(150),
  RegionRaw              VARCHAR(150)
);

-- Cleaned fact table
DROP TABLE IF EXISTS fct_nike_factories;
CREATE TABLE fct_nike_factories (
  FactoryID        INT AUTO_INCREMENT PRIMARY KEY,
  FactoryName      VARCHAR(255),
  FactoryType      VARCHAR(150),
  ProductType      VARCHAR(150),
  NikeBrands       VARCHAR(255),
  SupplierGroup    VARCHAR(255),
  City             VARCHAR(150),
  StateProv        VARCHAR(150),
  PostalCode       VARCHAR(60),
  Country          VARCHAR(150),
  Region           VARCHAR(150),
  CountryKey       INT NULL
);

-- Country lookup (from your country_region_mapping.csv)
DROP TABLE IF EXISTS dim_country;
CREATE TABLE dim_country (
  CountryKey   INT AUTO_INCREMENT PRIMARY KEY,
  Country      VARCHAR(150) NOT NULL,
  Region       VARCHAR(150) NULL,
  UNIQUE KEY uk_country (Country)
);
