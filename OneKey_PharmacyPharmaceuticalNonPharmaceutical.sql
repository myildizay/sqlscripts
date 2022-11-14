DECLARE @Period nvarchar(25)='1712'
DECLARE @ndfSQL AS VARCHAR(8000)
DECLARE @recSQL AS VARCHAR(8000)

DECLARE @NDF  TABLE
(
	Period nvarchar(4),
	PFC nvarchar(7),
	ProductName nvarchar(125),
	IsPharmaceutical bit
)
DECLARE @Transactions  TABLE
(
	Period nvarchar(4),
	CustomerCode nvarchar(7),
	PFC nvarchar(125),
	TotalUnit bigint
)

SET @ndfSQL = 'select '+@Period+', Prd_Cd, LongDescription , (case Prod_Flag when ''O'' THEN 0 ELSE 1 END) from TPINDF.dbo.ndf'+ @Period 
insert into @NDF exec (@ndfSQL);
select * from @NDF

SET @recSQL = 'SELECT  '+@Period+', cidims,pidims, sum(pr_unit+ pr_bonus) FROM TPIMN02.dbo.T'+@Period+'00 group by cidims,pidims'
insert into @Transactions exec (@recSQL);
select T.CustomerCode, SUM(TotalUnit) from @Transactions T 
INNER JOIN @NDF N ON N.Period = T.Period and N.PFC = T.PFC 
WHERE N.IsPharmaceutical=1 
group by T.CustomerCode
order by 1 

select T.CustomerCode, SUM(TotalUnit) from @Transactions T 
INNER JOIN @NDF N ON N.Period = T.Period and N.PFC = T.PFC 
WHERE N.IsPharmaceutical=0 
group by T.CustomerCode
order by 1 

SELECT * FROM TPIMN02.DBO.T171200
--create table  PharmaceuticalNonPharmaceuticalPharmacies (Period nvarchar(6), CustomerCode int , Pharmaceutical bit, NonPharmaceutical bit)
--create table  LogPharmaceuticalNonPharmaceuticalPharmacies (Period nvarchar(6), NumberOfPharmaceutical int , NumberOfNonPharmaceutical int)




