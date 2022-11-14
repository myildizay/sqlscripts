declare @Period nvarchar(6)='1904'

declare @ExecutionYear nvarchar(4)='20'+ left(@Period,2)


DECLARE @intFlag INT
SET @intFlag = @ExecutionYear-3
WHILE (@intFlag <@ExecutionYear)
BEGIN
    PRINT @intFlag
	SELECT * FROM TTROVERALL WHERE Year = @intFlag
    
	
	
	SET @intFlag = @intFlag + 1
	
END
GO


