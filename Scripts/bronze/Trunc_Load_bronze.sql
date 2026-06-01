/*
	Bronze stored procedure for loading the data from source to bronze layer
	The source here are .CSV files 
	This stored procedure first truncates the existing tables and then loads the data from the external csv files
	It uses the BULK INSERT command to load the data 
	This stored procedure doesnot takes any parameters
	Usage example- EXEC bronze.load_bronze
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
BEGIN TRY

DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME , @batch_end_time DATETIME;

SET @batch_start_time=GETDATE();
SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.crm_cust_info');
TRUNCATE TABLE bronze.crm_cust_info;

PRINT('Inserting into the table: bronze.crm_cust_info');
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';

SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.crm_prd_info');
TRUNCATE TABLE bronze.crm_prd_info;

PRINT('Inserting into the table: bronze.crm_prd_info');
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';
SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.crm_sales_details');
TRUNCATE TABLE bronze.crm_sales_details;

PRINT('Inserting into the table: bronze.crm_sales_details');
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';
SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.erp_cust_az12');
TRUNCATE TABLE bronze.erp_cust_az12;

PRINT('Inserting into the table: bronze.erp_cust_az12');
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';
SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.erp_loc_a101');
TRUNCATE TABLE bronze.erp_loc_a101

PRINT('Inserting into the table: bronze.erp_loc_a101');
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';
SET @start_time=GETDATE();
PRINT('Truncating the table: bronze.erp_px_cat_g1v2');
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

PRINT('Inserting into the table: bronze.erp_px_cat_g1v2');
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\harsh\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.CSV'
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
SET @end_time=GETDATE();
SET @batch_end_time=GETDATE();
PRINT 'Time taken: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR )+'Seconds';
PRINT 'Time taken for bronze layer: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR )+'Seconds';
END TRY
BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
END CATCH
END
