USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Header_STD_decomp]    Script Date: 04/29/2014 10:11:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_Header_STD_decomp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Header_STD_decomp]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Header_STD_decomp]    Script Date: 04/29/2014 10:11:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Header_STD_decomp]
AS

BEGIN




--BEGIN / INSERT TVD

INSERT INTO dbo.HeaderDecomposition (
  HeaderID
 ,DecompositionID
 ,GroupID
 ,TimeBoard
 ,BoardAmount
 ,UpdateTime
)

SELECT 
		 'HeaderID'			= replace(zakazky.opv, ' ', '') + '_' + CONVERT(VARCHAR,operace.polozka)
		,'DecompositionID'	= zakazky.nomenklatura
		,'GroupID'			= operace.zdroj
		,'TimeBoard'		= CASE 
			WHEN operace.tbs = NULL THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(operace.tas/60) AS varchar(2))+':'+CAST((FLOOR(operace.tas)-(FLOOR(operace.tas/60)*60)) AS varchar(2))+':'+CAST(FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(2)) + SUBSTRING(CONVERT(VARCHAR(8),CAST(((operace.tas - (FLOOR(operace.tas)))*60) - FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(9)),108),2,7),108),108)
			WHEN operace.tbs = 0 THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(operace.tas/60) AS varchar(2))+':'+CAST((FLOOR(operace.tas)-(FLOOR(operace.tas/60)*60)) AS varchar(2))+':'+CAST(FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(2)) + SUBSTRING(CONVERT(VARCHAR(8),CAST(((operace.tas - (FLOOR(operace.tas)))*60) - FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(9)),108),2,7),108),108)
			ELSE CONVERT(VARCHAR(16),
			CAST(CAST(FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))/60) AS NUMERIC (2)) AS VARCHAR(2))
			+':'+
			CAST(CAST(FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))) AS NUMERIC (2)) AS VARCHAR(2))
			+':'+
			CAST(CAST(((FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))*60) - FLOOR((operace.tas + ( operace.tbs / operace.planvyroba)))*60)) AS NUMERIC (2)) AS VARCHAR(2))
			+
			SUBSTRING(CAST(CAST((CAST(((operace.tas + ( operace.tbs / operace.planvyroba))*60) AS FLOAT) - CAST((FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))*60)) AS FLOAT))AS NUMERIC (8,7))AS VARCHAR(9)),2,7))
		END
		,'BoardAmount'		= operace.planvyroba
		,'UpdateTime'		= CASE 					
		   WHEN zakazky.ts > operace.ts THEN zakazky.ts				
		   ELSE operace.ts	 
		END 
  FROM KARATSQL.[KARAT_TVD].[dba].[v_opvvyrza] zakazky with(readuncommitted),
  KARATSQL.[KARAT_TVD].[dba].[v_opvoper] operace with(readuncommitted)
  where zakazky.opv = operace.opv
  AND zakazky.xpotvrzprev = 1
  AND zakazky.xukonceno <> 1
  AND zakazky.xuzavreno <> 1
  AND operace.planvyroba <> 0
  AND operace.operace_odm = 0
  AND zakazky.storno = 0 
  AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = operace.zdroj COLLATE Czech_CI_AS OR DeviceID = operace.zdroj COLLATE Czech_CI_AS)) = 1 
  AND (replace(zakazky.opv, ' ', '') + '_' + CONVERT(VARCHAR,operace.polozka)) NOT IN (SELECT HeaderID COLLATE Czech_CI_AS FROM dbo.HeaderDecomposition WHERE HeaderID = (replace(zakazky.opv, ' ', '') + '_' + CONVERT(VARCHAR,operace.polozka)) COLLATE Czech_CI_AS )

  ORDER BY replace(zakazky.opv, ' ', '') + '_' + CONVERT(VARCHAR,operace.polozka)
-- END OF INSERT




--BEGIN / UPDATE TVD

UPDATE z SET 

	 z.DecompositionID = y.DecompositionID
	,z.GroupID = y.GroupID
	,z.TimeBoard = y.TimeBoard
	,z.BoardAmount = y.BoardAmount
	,z.UpdateTime = y.UpdateTime 					

FROM (

SELECT 
		 'HeaderID'			= replace(zakazky.opv, ' ', '') + '_' + CONVERT(VARCHAR,operace.polozka)
		,'DecompositionID'	= zakazky.nomenklatura
		,'GroupID'			= operace.zdroj
		,'TimeBoard'		= CASE 
			WHEN operace.tbs = NULL THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(operace.tas/60) AS varchar(2))+':'+CAST((FLOOR(operace.tas)-(FLOOR(operace.tas/60)*60)) AS varchar(2))+':'+CAST(FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(2)) + SUBSTRING(CONVERT(VARCHAR(8),CAST(((operace.tas - (FLOOR(operace.tas)))*60) - FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(9)),108),2,7),108),108)
			WHEN operace.tbs = 0 THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(operace.tas/60) AS varchar(2))+':'+CAST((FLOOR(operace.tas)-(FLOOR(operace.tas/60)*60)) AS varchar(2))+':'+CAST(FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(2)) + SUBSTRING(CONVERT(VARCHAR(8),CAST(((operace.tas - (FLOOR(operace.tas)))*60) - FLOOR((operace.tas - (FLOOR(operace.tas)))*60) AS varchar(9)),108),2,7),108),108)
			ELSE CONVERT(VARCHAR(16),
			CAST(CAST(FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))/60) AS NUMERIC (2)) AS VARCHAR(2))
			+':'+
			CAST(CAST(FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))) AS NUMERIC (2)) AS VARCHAR(2))
			+':'+
			CAST(CAST(((FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))*60) - FLOOR((operace.tas + ( operace.tbs / operace.planvyroba)))*60)) AS NUMERIC (2)) AS VARCHAR(2))
			+
			SUBSTRING(CAST(CAST((CAST(((operace.tas + ( operace.tbs / operace.planvyroba))*60) AS FLOAT) - CAST((FLOOR((operace.tas + ( operace.tbs / operace.planvyroba))*60)) AS FLOAT))AS NUMERIC (8,7))AS VARCHAR(9)),2,7))
		END
		,'BoardAmount'		= operace.planvyroba
		,'UpdateTime'		= CASE 					
		   WHEN zakazky.ts > operace.ts THEN zakazky.ts				
		   ELSE operace.ts	 
		END 
  FROM KARATSQL.[KARAT_TVD].[dba].[v_opvvyrza] zakazky with(readuncommitted),
  KARATSQL.[KARAT_TVD].[dba].[v_opvoper] operace with(readuncommitted)
  where zakazky.opv = operace.opv
  AND zakazky.xpotvrzprev = 1
  AND zakazky.xukonceno <> 1
  AND zakazky.xuzavreno <> 1
  AND operace.planvyroba <> 0
  AND operace.operace_odm = 0  
  AND zakazky.storno = 0 
  AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = operace.zdroj COLLATE Czech_CI_AS OR DeviceID = operace.zdroj COLLATE Czech_CI_AS)) = 1 
		) y
		
		,dbo.HeaderDecomposition z
      
WHERE z.HeaderID COLLATE Czech_CI_AS  = y.HeaderID
AND z.UpdateTime < y.UpdateTime
-- END OF TVD UPDATE


END










GO


