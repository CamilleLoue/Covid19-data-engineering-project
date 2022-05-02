CREATE SCHEMA [covid_reporting]
GO

CREATE TABLE [covid_reporting].[population] (
  [country] varchar(100),
  [country_code_2_digit] varchar(2) not null,
  [population] bigint,
  [age_group_0_14] float,
  [age_group_15_24] float,
  [age_group_25_49] float,
  [age_group_50_64] float,
  [age_group_65_79] float,
  [age_group_80_max] float
)

CREATE TABLE [covid_reporting].[lookup] (
  [reported_year_week] varchar(8) not null,
  [country_code_2_digit] varchar(2) not null
)

CREATE TABLE [covid_reporting].[testing] (
  [country_code_2_digit] varchar(2) not null,
  [reported_year_week] varchar(8) not null,
  [week_start_date] date,
  [week_end_date] date,
  [tests_done] bigint,
  [testing_rate] float,
  [positivity_rate] float,
  [testing_data_source] varchar(500)
)
GO

CREATE TABLE [covid_reporting].[cases_deaths] (
  [country_code_2_digit] varchar(2) not null,
  [weekly_cases_count] bigint,
  [weekly_deaths_count] bigint,
  [reported_year_week] varchar(8) not null
)
GO

CREATE TABLE [covid_reporting].[hospital_admissions_weekly] (
  [country_code_2_digit] varchar(2) not null,
  [reported_year_week] varchar(8) not null,
  [hospital_occupancy_count] bigint,
  [icu_occupancy_count] bigint,
  [source] varchar(500)
)
GO

ALTER TABLE [covid_reporting].[population] ADD PRIMARY KEY ([country_code_2_digit])
GO

ALTER TABLE [covid_reporting].[lookup] ADD FOREIGN KEY ([country_code_2_digit]) REFERENCES [covid_reporting].[population] ([country_code_2_digit]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [covid_reporting].[lookup] ADD PRIMARY KEY ([country_code_2_digit],[reported_year_week])
GO

ALTER TABLE [covid_reporting].[testing] ADD FOREIGN KEY ([country_code_2_digit],[reported_year_week]) REFERENCES [covid_reporting].[lookup] ([country_code_2_digit],[reported_year_week]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [covid_reporting].[cases_deaths] ADD FOREIGN KEY ([country_code_2_digit],[reported_year_week]) REFERENCES [covid_reporting].[lookup] ([country_code_2_digit],[reported_year_week]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [covid_reporting].[hospital_admissions_weekly] ADD FOREIGN KEY ([country_code_2_digit],[reported_year_week]) REFERENCES [covid_reporting].[lookup] ([country_code_2_digit],[reported_year_week]) ON DELETE CASCADE ON UPDATE CASCADE
GO