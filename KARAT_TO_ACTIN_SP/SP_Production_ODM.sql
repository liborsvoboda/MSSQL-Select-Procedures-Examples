USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Production_ODM]    Script Date: 04/29/2014 10:11:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_Production_ODM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Production_ODM]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Production_ODM]    Script Date: 04/29/2014 10:11:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Production_ODM]
AS

BEGIN

--BEGIN / INSERT TVD  ODM
INSERT INTO dbo.Production (
  Production_ID
 ,HeaderID
 ,EmployeeCode
 ,DeviceID
 ,ProduceCount
 ,OperationStart
 ,OperationEnd
 ,UpdateTime
)

  SELECT  
		 'Production_ID' = term_data.inc
		,'HeaderID' = header_dkl.job
	  	,'EmployeeCode' = term_data.oscislo 
		,'DeviceID' = term_data.zdroj
		,'ProduceCount' = CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.mnozstvi_odv 
			ELSE NULL 
		END 
		,'OperationStart' =  CASE 
			WHEN term_data.typ_udalosti = 'WS' THEN term_data.ts 
			ELSE NULL
		END	
		,'OperationEnd' =  CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.ts 
			ELSE NULL
		END	
		
		,'UpdateTime' =  term_data.ts
		
  FROM KARATSQL.KARAT_TVD.[dba].[v_ter_data] term_data with(readuncommitted),
       KARATSQL.KARAT_TVD.[dba].[v_odm_nest_dkl] header_dkl with(readuncommitted)
  
  WHERE
	(	term_data.typ_udalosti = 'WS' 
	 OR term_data.typ_udalosti = 'WF' 
	) 
	 AND RIGHT(term_data.id_vyr_oper,DATALENGTH(term_data.id_vyr_oper)-1) = header_dkl.doklad
	 AND term_data.zdroj <> ''
	 AND header_dkl.job = header_dkl.nesting 
  	 AND header_dkl.job IN (SELECT HeaderID COLLATE Czech_CI_AS FROM dbo.[HeaderDecomposition] with(readuncommitted) WHERE HeaderID = header_dkl.job COLLATE Czech_CI_AS )
     AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice with(readuncommitted) WHERE (GroupID = term_data.zdroj COLLATE Czech_CI_AS OR DeviceID = term_data.zdroj COLLATE Czech_CI_AS)) = 1  
     AND term_data.inc NOT IN (SELECT Production_ID FROM dbo.Production with(readuncommitted) WHERE Production_ID = term_data.inc )
     AND term_data.stav = 1
     
     ORDER BY term_data.inc
--END INSERT TVD
 
 
 
 





--BEGIN / UPDATE TVD ODM
UPDATE z SET 

  z.HeaderID		= y.HeaderID
 ,z.EmployeeCode	= y.EmployeeCode
 ,z.DeviceID		= y.DeviceID
 ,z.ProduceCount	= y.ProduceCount
 ,z.OperationStart	= y.OperationStart
 ,z.OperationEnd	= y.OperationEnd
 ,z.UpdateTime		= y.UpdateTime

FROM 
(
  SELECT 
		 'Production_ID' = term_data.inc
		,'HeaderID' = header_dkl.job
	  	,'EmployeeCode' = term_data.oscislo 
		,'DeviceID' = term_data.zdroj
		,'ProduceCount' = CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.mnozstvi_odv 
			ELSE NULL 
		END 
--		,term_data.mnozstvi_nesh_v --neshody vlastní
--		,term_data.mnozstvi_nesh_c --neshody cizí
		,'OperationStart' =  CASE 
			WHEN term_data.typ_udalosti = 'WS' THEN term_data.ts 
			ELSE NULL
		END	
		,'OperationEnd' =  CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.ts 
			ELSE NULL
		END	
		
		,'UpdateTime' =  term_data.ts
		
  FROM KARATSQL.KARAT_TVD.[dba].[v_ter_data] term_data with(readuncommitted),
       KARATSQL.KARAT_TVD.[dba].[v_odm_nest_dkl] header_dkl with(readuncommitted)
  
  WHERE
	(	term_data.typ_udalosti = 'WS' 
	 OR term_data.typ_udalosti = 'WF' 
	) 
	 AND RIGHT(term_data.id_vyr_oper,DATALENGTH(term_data.id_vyr_oper)-1) = header_dkl.doklad
	 AND term_data.zdroj <> ''
	 AND term_data.oscislo <> ''
	 AND header_dkl.job = header_dkl.nesting 
     AND term_data.inc IN (SELECT Production_ID FROM dbo.Production with(readuncommitted) WHERE Production_ID = term_data.inc )
     AND term_data.stav = 1
     
 ) y
		,dbo.Production z  with(readuncommitted)
WHERE z.Production_ID = y.Production_ID
AND z.UpdateTime < y.UpdateTime


--END UPDATE TVD



END





GO


