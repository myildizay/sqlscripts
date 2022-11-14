SELECT  [dbo].[GetPercentageOfTwoStringMatching]('valentin123456'  ,'valnetin123456')


SELECT  APD.ProductName ,  APB.ProductName ,[dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) FROM AccountProductData APD 
LEFT JOIN AccountProductBridge APB ON APB.AccountID = APD.AccountID
AND APB.ProductID = APD.ProductID 
AND APB.ProductName  = APD.ProductName 
where 
APD.CycleID = 17
and APD.AccountID = 180



SELECT APD.ProductName ,  APB.ProductName ,[dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) Dif FROM AccountProductData APD 
LEFT JOIN AccountProductBridge APB ON APB.AccountID = APD.AccountID
AND APB.ProductID <> APD.ProductID 
AND APB.ProductName  = APD.ProductName 
where 
APD.CycleID = 17
and APD.AccountID = 180
AND APB.ProductName is not null

SELECT APD.ProductName ,  APB.ProductName ,[dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) Dif  FROM AccountProductData APD 
INNER JOIN AccountProductBridge APB ON APB.AccountID = APD.AccountID
--AND APB.ProductID <> APD.ProductID 
--AND APB.ProductName  = APD.ProductName 
--and APB.Barcode =APD.Barcode
where 
APD.CycleID = 17
and APD.AccountID = 180
AND [dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName)=100
AND APB.ProductName is not null
ORDER BY Dif 


SELECT APD.ProductName ,APD.AccountID , APD.CycleID,  APB.ProductName ,[dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) Dif FROM AccountProductData APD 
LEFT JOIN AccountProductBridge APB ON APB.AccountID = APD.AccountID 
where 
APD.CycleID = 17
and APD.AccountID = 180
AND [dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName)=100

SELECT APD.ProductName ,  APB.ProductName ,[dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) Dif FROM AccountProductData APD 
LEFT JOIN AccountProductBridge APB ON APB.AccountID = APD.AccountID 
where 
APD.CycleID = 17
and APD.AccountID = 180
AND [dbo].[GetPercentageOfTwoStringMatching]( APD.ProductName   , APB.ProductName) BETWEEN  90 AND 99 
