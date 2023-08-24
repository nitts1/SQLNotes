--Query to calculate 3 Standard deviations from a table or a view for all the numerical culumns

--STEP 1 : Get List of Colum name for Table/view
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'vw_InterventionOutputForAlgorithm'

--STEP 2 : Exclude all the categorical Columns from the selction
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'vw_InterventionOutputForAlgorithm' AND COLUMN_NAME NOT IN ('Property ID','Property Name','Site','Country','Region','Latitude','Longitude','Building Typology','Intervention','ChosenInterventionForRoadmap','Fuel Source Before Intervention','Fuel Source After Intervention','Lease Expiry Date')

--STEP 3 : Select all the columns dynamically to calculate 3 SDs
SELECT 'select Intervention,[Building Typology]' + STRING_AGG(

CONCAT('
(AVG([',CAST(COLUMN_NAME AS VARCHAR(MAX)),']) - (1.5  *  STDEV([',COLUMN_NAME,']))) AS [',COLUMN_NAME,' R1],
(AVG([',COLUMN_NAME,']) + (1.5  *  STDEV([',COLUMN_NAME,']))) AS [',COLUMN_NAME,' R2]'), ', ') + ' FROM vw_InterventionOutputForAlgorithm GROUP BY Intervention,[Building Typology]' 

AS qry

FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'vw_InterventionOutputForAlgorithm' AND COLUMN_NAME NOT IN ('Property ID','Property Name','Site','Country','Region','Latitude','Longitude','Building Typology','Intervention','ChosenInterventionForRoadmap','Fuel Source Before Intervention','Fuel Source After Intervention','Lease Expiry Date')

--STEP 4 : Create CTE to select the table
with CTE
AS
(
    -- Output of STEP 3
)
SELECT * FROM CTE