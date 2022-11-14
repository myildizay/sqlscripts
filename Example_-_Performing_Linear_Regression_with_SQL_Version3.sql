--****************************************************************************
--
--	Example for Peforming Linear Regression with SQL
--  Author:  Mark Wojciechowicz
--  Date:  12/29/2009
--
--****************************************************************************



--*****************************************************************************
--
--	Step 1 - Create a table variable and insert test data.  
--		Test data is stripped of promotions and aggregated to a monthly level.
--		Then update smoothed_quantity with a central moving average
--		
--*****************************************************************************

-- Create Table Variable to hold results
Declare @ForecastTable as Table (
				ForecastKey int, 
				CYear int, 
				CMonth int, 
				Product nvarchar(25),
				Baseline_Quantity int, 
				Smoothed_Quantity int, 
				Trend numeric(38,17), 
				Seasonality numeric(38,17),
				Forward_Trend Numeric(38,17),
				Forecast Numeric(38,17))

-- Insert Monthly History for 2 products, assuming that promotions have already been cleansed
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (1, 2006, 1, 'Widget A', 1163)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (2, 2006, 2, 'Widget A', 813)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (3, 2006, 3, 'Widget A', 1101)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (4, 2006, 4, 'Widget A', 1376)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (5, 2006, 5, 'Widget A', 1066)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (6, 2006, 6, 'Widget A', 1163)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (7, 2006, 7, 'Widget A', 1488)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (8, 2006, 8, 'Widget A', 1280)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (9, 2006, 9, 'Widget A', 1853)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (10, 2006, 10, 'Widget A', 1387)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (11, 2006, 11, 'Widget A', 1275)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (12, 2006, 12, 'Widget A', 1711)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (13, 2007, 1, 'Widget A', 1758)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (14, 2007, 2, 'Widget A', 1364)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (15, 2007, 3, 'Widget A', 1358)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (16, 2007, 4, 'Widget A', 1851)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (17, 2007, 5, 'Widget A', 1538)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (18, 2007, 6, 'Widget A', 1670)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (19, 2007, 7, 'Widget A', 2221)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (20, 2007, 8, 'Widget A', 1212)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (21, 2007, 9, 'Widget A', 427)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (22, 2007, 10, 'Widget A', 1675)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (23, 2007, 11, 'Widget A', 1883)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (24, 2007, 12, 'Widget A', 1660)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (25, 2008, 1, 'Widget A', 1971)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (26, 2008, 2, 'Widget A', 1395)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (27, 2008, 3, 'Widget A', 1960)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (28, 2008, 4, 'Widget A', 2011)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (29, 2008, 5, 'Widget A', 1765)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (30, 2008, 6, 'Widget A', 1632)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (31, 2008, 7, 'Widget A', 2342)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (32, 2008, 8, 'Widget A', 2003)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (33, 2008, 9, 'Widget A', 1597)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (34, 2008, 10, 'Widget A', 900)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (35, 2008, 11, 'Widget A', 1979)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (36, 2008, 12, 'Widget A', 2113)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (1, 2006, 6, 'Widget B', 963)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (2, 2006, 7, 'Widget B', 1190)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (3, 2006, 8, 'Widget B', 1021)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (4, 2006, 9, 'Widget B', 696)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (5, 2006, 10, 'Widget B', 820)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (6, 2006, 11, 'Widget B', 822)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (7, 2006, 12, 'Widget B', 613)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (8, 2007, 1, 'Widget B', 1309)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (9, 2007, 2, 'Widget B', 584)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (10, 2007, 3, 'Widget B', 843)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (11, 2007, 4, 'Widget B', 1449)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (12, 2007, 5, 'Widget B', 2225)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (13, 2007, 6, 'Widget B', 3132)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (14, 2007, 7, 'Widget B', 2943)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (15, 2007, 8, 'Widget B', 1634)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (16, 2007, 9, 'Widget B', 1594)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (17, 2007, 10, 'Widget B', 1666)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (18, 2007, 11, 'Widget B', 1143)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (19, 2007, 12, 'Widget B', 1116)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (20, 2008, 1, 'Widget B', 1570)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (21, 2008, 2, 'Widget B', 1221)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (22, 2008, 3, 'Widget B', 1283)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (23, 2008, 4, 'Widget B', 2223)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (24, 2008, 5, 'Widget B', 2569)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (25, 2008, 6, 'Widget B', 2298)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (26, 2008, 7, 'Widget B', 3704)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (27, 2008, 8, 'Widget B', 2502)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (28, 2008, 9, 'Widget B', 2575)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (29, 2008, 10, 'Widget B', 2691)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (30, 2008, 11, 'Widget B', 2101)
	Insert into @ForecastTable (Forecastkey, Cyear, Cmonth, Product, Baseline_Quantity) Values (31, 2008, 12, 'Widget B', 1899)


-- Update smoothed_Quantity with Central Moving Average

	Update 
		@ForecastTable 
	SET 
		Smoothed_Quantity = MovAvg.Smoothed_Quantity
	FROM(
		SELECT 
			a.ForecastKey as FKey,
			a.Product as Prod, 
			Round(AVG(Cast(b.baseline_Quantity as numeric(14,1))),0) Smoothed_Quantity
		FROM 
			@ForecastTable a
		INNER JOIN 
			@ForecastTable b 
		ON 
			a.Product = b.Product 
			AND	(a.ForecastKey - b.ForecastKey) BETWEEN -3 AND 3
		GROUP BY
			a.ForecastKey,
			a.Product) MovAvg
	WHERE 
		Product = MovAvg.Prod
		AND ForecastKey = MovAvg.FKey
	
--****************************************************************************************
--
--	Step 2 - Create a second table variable to hold the trend formula by item.  
--		This step is performed with an insert and update to make the calculations more clear
--		It could just as easily be performed with a single insert.
--		Lastly, update the trend for historical data and calculate seasonality
--
--*****************************************************************************************

	-- Create table to store calculations by Item
	DECLARE @Formula as Table(
					Product nvarchar(25),
					Counts int,  
					SumX Numeric(14,4), 
					SumY Numeric(14,4),
					SumXY Numeric(14,4), 
					SumXsqrd Numeric(14,4), 
					b Numeric(38,17), 
					a Numeric(38,17))
	
	INSERT INTO @Formula (Product, Counts, SumX, SumY, SumXY, SumXsqrd)	
		(SELECT 
			Product,
			COUNT(*),
			sum(ForecastKey),
			sum(Smoothed_Quantity),
			sum(Smoothed_Quantity * ForecastKey),
			sum(power(ForecastKey,2)) 
		FROM 
			@ForecastTable
		WHERE 
			Smoothed_Quantity IS NOT NULL
		GROUP BY 
			Product)
		
		-- Calculate B (Slope)
		UPDATE @Formula 
		SET
			b = ((tb.counts * tb.sumXY)-(tb.sumX * tb.sumY))/ (tb.Counts * tb.sumXsqrd - power(tb.sumX,2))
		FROM
			(SELECT Product as XProduct, Counts, SumX, SumY, SumXY, SumXsqrd FROM @Formula) tb
		WHERE Product = tb.XProduct
		
		--Calculate A (Y Intercept)
		UPDATE 
			@Formula 
		SET
			a = ((tb2.sumY - tb2.b * tb2.sumX) / tb2.Counts)
		FROM
			(SELECT Product as XProduct, Counts, SumX, SumY, SumXY, SumXsqrd, b FROM @Formula) tb2
		WHERE Product = tb2.XProduct
		
		-- Update Historical Trend and Seasonality
		--y = a + bx
		--Forecast = Y Intercept + (Slope * ForecastKey)
		UPDATE 
			@ForecastTable 
		SET 
			Trend = A + (B * ForecastKey),
			Seasonality = CASE WHEN Baseline_Quantity = 0 
				THEN 1 ELSE Baseline_Quantity /(A + (B * ForecastKey)) END
		FROM
		 (SELECT Product as XProduct, Counts, SumX, SumY, SumXY, SumXsqrd, b, a FROM @Formula) TrendUpdate
		WHERE Product = TrendUpdate.XProduct

--**********************************************************************************
--
--	Step 3 - Insert Trendline and forecast into Forecast table 
--		
--**********************************************************************************

		-- Create Forecast
		DECLARE @Loop as int = 0
		
		WHILE @Loop <12
			BEGIN
				INSERT INTO @ForecastTable (ForecastKey, CYear, CMonth, Product, Forward_Trend, Forecast)
				SELECT 
					MAX(Forecastkey) + 1,  --Create Forecastkey
					2009, -- Dates could be incremented by joining to a date dimension or using Dateadd for a date type
					@Loop +1,
					a.Product,
					MAX(A) + (MAX(B) * (MAX(Forecastkey) + 1)), -- Trendline
					(MAX(A) + (MAX(B) * (MAX(Forecastkey) + 1)))
					*  
					(SELECT 
						Case WHEN avg(Seasonality) = 0 THEN 1 ELSE avg(Seasonality) END 
					FROM 
						@ForecastTable SeasonalMask
					WHERE 
						SeasonalMask.Product = a.Product
						AND SeasonalMask.CMonth = @Loop +1)-- Trendline * Avg seasonality
				FROM 
					@ForecastTable a
				INNER JOIN 
					@Formula b
				ON 
					a.Product = b.Product
				GROUP BY 
					a.Product
			
				
			SET @Loop = @Loop +1
			END
		
		-- Review results
		SELECT * FROM @ForecastTable ORDER BY Product, Forecastkey

