/****** ***** ***** ***** ***** ***** ***** ***** 
Creation of the Thales Stock Predictor Database
Using Data from Yahoo Finance
Author: James Laurence
Date: January 16th, 2024/February 15th, 2024
DBAS3090 - ICE 1 requirement
****** ***** ***** ***** ***** ***** ***** *****/

-- Creates Thales Stock Predictor Database
CREATE Database ThalesStockPredictor
GO
-- Uses the newly Created ThalesStockPredictor database
USE [ThalesStockPredictor]
GO
-- Creation of the Date table
CREATE TABLE [dbo].[DATE](
	[DT_Date] [date] PRIMARY KEY, -- Primary Key set
)
GO
/*
This script will generate the date range required for the DATE table 
to allowed it being used as foreign key. 
Used ChatGPT for help with script generation
*/
-- variables for the date range
DECLARE @StartDate DATE = '1999-01-01';
DECLARE @EndDate DATE = '2050-12-31';

-- Populate the date_table
WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DATE (DT_Date)
    SELECT @StartDate
    WHERE NOT EXISTS (
        SELECT 1
        FROM DATE
        WHERE DT_Date = @StartDate
    );
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END
GO
-- Create Thales stock table
CREATE TABLE [dbo].[THALES_STOCK](
	[FK_DT_Date] [date] PRIMARY KEY, -- Primary Key set
	THALES_Open [float](10),
	THALES_High [float](10),
	THALES_Low [float](10),
	THALES_Close [float](10),
	THALES_Adj_Close [float](10),
	THALES_Volume [float](10)
)
GO
-- Create Standard & Poor Index table
CREATE TABLE [dbo].[S_P_INDEX](
	[FK_DT_Date] [date] PRIMARY KEY, -- Primary Key set
	SPI_Open [float](10),
	SPI_High [float](10),
	SPI_Low [float](10),
	SPI_Close [float](10),
	SPI_Adj_Close [float](10),
	SPI_Volume [float](10)
)
GO
-- Create France Market Index table
CREATE TABLE [dbo].[FRANCE_INDEX](
	[FK_DT_Date] [date] PRIMARY KEY, -- Primary Key set
	FRA_Open [float](10),
	FRA_High [float](10),
	FRA_Low [float](10),
	FRA_Close [float](10),
	FRA_Adj_Close [float](10),
	FRA_Volume [float](10)
)
GO
-- Create Euro Market Index table
CREATE TABLE [dbo].[EURO_INDEX](
	[FK_DT_Date] [date] PRIMARY KEY, -- Primary Key set
	EUR_Open [float](10),
	EUR_High [float](10),
	EUR_Low [float](10),
	EUR_Close [float](10),
	EUR_Adj_Close [float](10),
	EUR_Volume [float](10)
)
GO
-----------------------------------------------
-- Model RSME Result Table
-----------------------------------------------
CREATE TABLE [dbo].[MODEL_RMSE](
	MODEL_TimeStamp [datetime] PRIMARY KEY default(current_timestamp), 
	MODEL_RMSE [float] NOT NULL
)
GO
--------------------------------------------------------------------------------------
-- Creation of High RMSE Value which should be overwritten by R Model RMSE
--INSERT INTO MODEL_RMSE (MODEL_RMSE)
--VALUES (99999)
--DROP TABLE [dbo].[MODEL_RMSE]
--------------------------------------------------------------------------------------
-- set foreign keys after table creations
ALTER TABLE THALES_STOCK
ADD CONSTRAINT Thales_FK_Date FOREIGN KEY (FK_DT_Date) 
REFERENCES [DATE](DT_Date)
ON DELETE CASCADE
ON UPDATE CASCADE
GO
ALTER TABLE S_P_INDEX
ADD CONSTRAINT SP500_FK_Date FOREIGN KEY (FK_DT_Date) 
REFERENCES [DATE](DT_Date)
ON DELETE CASCADE
ON UPDATE CASCADE
GO
ALTER TABLE FRANCE_INDEX
ADD CONSTRAINT France_FK_Date FOREIGN KEY (FK_DT_Date) 
REFERENCES [DATE](DT_Date)
ON DELETE CASCADE
ON UPDATE CASCADE
GO
ALTER TABLE EURO_INDEX
ADD CONSTRAINT Euro_FK_Date FOREIGN KEY (FK_DT_Date) 
REFERENCES [DATE](DT_Date)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO