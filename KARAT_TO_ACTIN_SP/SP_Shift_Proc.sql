USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Shift]    Script Date: 04/29/2014 10:11:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_Shift]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Shift]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Shift]    Script Date: 04/29/2014 10:11:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Shift]
AS

BEGIN

--BEGIN / INSERT TVD
INSERT INTO dbo.Shift (
  DeviceID
 ,[Date]
 ,ShiftID
 ,ShiftName
 ,TimeFrom
 ,TimeTo
 ,UpdateTime
)

SELECT 					
		 DeviceID = zdroj.zdroj			
        ,[Date] = zdr_kalendar.datum
		,ShiftID = zdr_kalendar.smena
        ,ShiftName = CASE					
			WHEN zdr_kalendar.smena = 1 THEN 'směna ranní'		
			WHEN zdr_kalendar.smena = 2 THEN 'směna odpolední'		
			WHEN zdr_kalendar.smena = 3 THEN 'směna noční'		
			WHEN zdr_kalendar.smena = 4 THEN 'směna 4'		
			WHEN zdr_kalendar.smena = 5 THEN 'směna 5'		
			WHEN zdr_kalendar.smena = 6 THEN 'směna 6'		
			ELSE 'Neidentifikováno'		
        END				
        ,TimeFrom = zdr_kalendar.od_data
        ,TimeTo = zdr_kalendar.do_data
        ,UpdateTime = CASE 					
		   WHEN zdr_kalendar.ts > zdroj.ts THEN zdr_kalendar.ts			
		   ELSE zdroj.ts			
       END 					
  FROM KARATSQL.[KARAT_TVD].[dba].[zdr_zdr] zdroj with(readuncommitted),KARATSQL.[KARAT_TVD].[dba].[zdr_zdr_gen] zdr_kalendar with(readuncommitted)					
  WHERE					
  	  zdroj.xplan =420				
  AND zdroj.zdroj = zdr_kalendar.zdroj	  				
  AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = zdroj.zdroj COLLATE Czech_CI_AS OR DeviceID = zdroj.zdroj COLLATE Czech_CI_AS)) = 1 
  AND zdr_kalendar.od_data >= GETDATE()					
  AND zdroj.zdroj NOT IN (SELECT DeviceID COLLATE Czech_CI_AS FROM dbo.Shift WHERE DeviceID = zdroj.zdroj  COLLATE Czech_CI_AS AND [DATE] = zdr_kalendar.datum AND ShiftID = zdr_kalendar.smena )
  AND zdr_kalendar.od_data <> zdr_kalendar.do_data
  ORDER BY zdroj.zdroj,zdr_kalendar.datum,zdr_kalendar.smena					

-- END OF INSERT





--BEGIN / UPDATE TVD

UPDATE z SET 

  z.ShiftName = y.ShiftName
 ,z.TimeFrom  = y.TimeFrom
 ,z.TimeTo	  = y.TimeTo
 ,z.UpdateTime= y.UpdateTime

FROM ( SELECT 					
		 DeviceID = zdroj.zdroj			
        ,[Date] = zdr_kalendar.datum
		,ShiftID = zdr_kalendar.smena
        ,ShiftName = CASE					
			WHEN zdr_kalendar.smena = 1 THEN 'směna ranní'		
			WHEN zdr_kalendar.smena = 2 THEN 'směna odpolední'		
			WHEN zdr_kalendar.smena = 3 THEN 'směna noční'		
			WHEN zdr_kalendar.smena = 4 THEN 'směna 4'		
			WHEN zdr_kalendar.smena = 5 THEN 'směna 5'		
			WHEN zdr_kalendar.smena = 6 THEN 'směna 6'		
			ELSE 'Neidentifikováno'		
        END					
        ,TimeFrom = zdr_kalendar.od_data
        ,TimeTo = zdr_kalendar.do_data
        ,UpdateTime = CASE 					
		   WHEN zdr_kalendar.ts > zdroj.ts THEN zdr_kalendar.ts			
		   ELSE zdroj.ts			
       END 					
  FROM KARATSQL.[KARAT_TVD].[dba].[zdr_zdr] zdroj with(readuncommitted),KARATSQL.[KARAT_TVD].[dba].[zdr_zdr_gen] zdr_kalendar with(readuncommitted)					
  WHERE					
  	  zdroj.xplan =420				
  AND zdroj.zdroj = zdr_kalendar.zdroj	  				
  AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = zdroj.zdroj COLLATE Czech_CI_AS OR DeviceID = zdroj.zdroj COLLATE Czech_CI_AS)) = 1 
  AND zdr_kalendar.od_data >= GETDATE()					
  AND zdr_kalendar.od_data <> zdr_kalendar.do_data
		) y
		
		,dbo.Shift z
      
WHERE z.DeviceID COLLATE Czech_CI_AS  = y.DeviceID
 AND z.[Date] = y.[Date]
 AND z.ShiftID = y.ShiftID
 AND z.UpdateTime < y.UpdateTime
-- END OF TVD UPDATE





END







GO


