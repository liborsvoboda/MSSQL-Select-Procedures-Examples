USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_START_TERMINAL_TRANSFER]    Script Date: 04/29/2014 10:11:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_START_TERMINAL_TRANSFER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_START_TERMINAL_TRANSFER]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_START_TERMINAL_TRANSFER]    Script Date: 04/29/2014 10:11:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_START_TERMINAL_TRANSFER]
AS

BEGIN




--BEGIN / INSERT TVD

INSERT INTO dbo.Production (
  Production_ID
 ,HeaderID
 ,EmployeeCode
 ,DeviceID
 ,ProduceCount
-- ,mnozstvi_nesh_v
-- ,mnozstvi_nesh_c
 ,OperationStart
 ,OperationEnd
 ,UpdateTime
)

SELECT  
  'Production_ID'  = user_term_data.Production_ID
 ,'HeaderID'	   = user_term_data.HeaderID
 ,'EmployeeCode'   = user_term_data.EmployeeCode
 ,'DeviceID'	   = user_term_data.DeviceID
 ,'ProduceCount'   = user_term_data.ProduceCount
-- ,mnozstvi_nesh_v = user_term_data.mnozstvi_nesh_v
-- ,mnozstvi_nesh_c = user_term_data.mnozstvi_nesh_c
 ,'OperationStart' = user_term_data.OperationStart
 ,'OperationEnd'   = user_term_data.OperationEnd
 ,'UpdateTime'     = user_term_data.UpdateTime
 
 FROM 
	KARATSQL.KARAT_TVD.[dba].[user_v_ter_data] user_term_data  with(readuncommitted)
 
 WHERE 
    user_term_data.stav = 0
	AND user_term_data.Production_ID NOT IN (SELECT Production_ID FROM dbo.Production WHERE Production_ID = user_term_data.Production_ID )


-- END OF INSERT


-- BEGIN OF UPDATE TVD
UPDATE z SET 

  z.HeaderID		= y.HeaderID
 ,z.EmployeeCode	= y.EmployeeCode
 ,z.DeviceID		= y.DeviceID
 ,z.ProduceCount	= y.ProduceCount
 -- ,z.mnozstvi_nesh_v = y.mnozstvi_nesh_v
-- ,z.mnozstvi_nesh_c = y.mnozstvi_nesh_c
 ,z.OperationStart	= y.OperationStart
 ,z.OperationEnd	= y.OperationEnd
 ,z.UpdateTime		= y.UpdateTime

FROM 
(
	SELECT  
	  'Production_ID'  = user_term_data.Production_ID
	 ,'HeaderID'	   = user_term_data.HeaderID
	 ,'EmployeeCode'   = user_term_data.EmployeeCode
	 ,'DeviceID'	   = user_term_data.DeviceID
	 ,'ProduceCount'   = user_term_data.ProduceCount
-- ,mnozstvi_nesh_v = user_term_data.mnozstvi_nesh_v
-- ,mnozstvi_nesh_c = user_term_data.mnozstvi_nesh_c
	 ,'OperationStart' = user_term_data.OperationStart
	 ,'OperationEnd'   = user_term_data.OperationEnd
	 ,'UpdateTime'     = user_term_data.UpdateTime
	 
	 FROM 
		KARATSQL.KARAT_TVD.[dba].[user_v_ter_data] user_term_data  with(readuncommitted)
	 
	 WHERE 
		user_term_data.Production_ID IN (SELECT Production_ID FROM dbo.Production WHERE Production_ID = user_term_data.Production_ID )
		AND user_term_data.stav = 0
 ) y
		,dbo.Production z 
WHERE z.Production_ID = y.Production_ID
AND z.UpdateTime < y.UpdateTime

----END UPDATE TVD

UPDATE KARATSQL.KARAT_TVD.[dba].[user_v_ter_data] SET
	stav=1 
	WHERE stav = 0


END





GO


