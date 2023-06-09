USE [TVD]
GO
/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Production_STD]    Script Date: 05/21/2014 06:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Production_STD]
AS

BEGIN




--BEGIN / INSERT TVD standardní zakázky
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
		 'Production_ID' = term_data.inc
		,'HeaderID' = (REPLACE(poz_zdroju.doklad, ' ', '') + '_' + CONVERT(VARCHAR, poz_zdroju.polozka))

	  	,'EmployeeCode' = term_data.oscislo 
		,'DeviceID' = term_data.zdroj
		,'ProduceCount' = CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.mnozstvi_odv 
			ELSE NULL 
		END 
--		,'mnozstvi_nesh_v' = term_data.mnozstvi_nesh_v
--		,'mnozstvi_nesh_c' = term_data.mnozstvi_nesh_c
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
       KARATSQL.KARAT_TVD.[dba].[v_ter_in] imported_data with(readuncommitted),
       KARATSQL.KARAT_TVD.[dba].[zdr_poz] poz_zdroju with(readuncommitted)
       
       
  
  
  WHERE
	(	term_data.typ_udalosti = 'WS' 
	 OR term_data.typ_udalosti = 'WF' 
	) 
	 AND term_data.zdroj <> ''
	 AND term_data.id_vyr_oper = imported_data.id_vyr_oper
	 AND term_data.id_procesu = imported_data.id_procesu
	 AND term_data.typ_udalosti = imported_data.typ_udalosti
     AND term_data.stav = 1
     AND '1000000000' + CONVERT(VARCHAR, poz_zdroju.id_poz) = term_data.id_vyr_oper
  	 AND (REPLACE(poz_zdroju.doklad, ' ', '') + '_' + CONVERT(VARCHAR, poz_zdroju.polozka)) IN (SELECT HeaderID COLLATE Czech_CI_AS FROM dbo.[HeaderDecomposition] with(readuncommitted) WHERE HeaderID = (REPLACE(poz_zdroju.doklad, ' ', '') + '_' + CONVERT(VARCHAR, poz_zdroju.polozka)) COLLATE Czech_CI_AS )
     AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice with(readuncommitted) WHERE (GroupID = term_data.zdroj COLLATE Czech_CI_AS OR DeviceID = term_data.zdroj COLLATE Czech_CI_AS)) = 1  
     AND term_data.inc NOT IN (SELECT Production_ID FROM dbo.Production with(readuncommitted) WHERE Production_ID = term_data.inc )
     
     ORDER BY term_data.inc

--END INSERT TVD standardní zakázky







--BEGIN / UPDATE TVD standardní zakázky
UPDATE z SET 

  z.HeaderID		= y.HeaderID
 ,z.EmployeeCode	= y.EmployeeCode
 ,z.DeviceID		= y.DeviceID
 ,z.ProduceCount	= y.ProduceCount
-- ,mnozstvi_nesh_v
-- ,mnozstvi_nesh_c
 ,z.OperationStart	= y.OperationStart
 ,z.OperationEnd	= y.OperationEnd
 ,z.UpdateTime		= y.UpdateTime

FROM 
(
  SELECT 
		 'Production_ID' = term_data.inc
		,'HeaderID' = (REPLACE(poz_zdroju.doklad, ' ', '') + '_' + CONVERT(VARCHAR, poz_zdroju.polozka))

	  	,'EmployeeCode' = term_data.oscislo 
		,'DeviceID' = term_data.zdroj
		,'ProduceCount' = CASE 
			WHEN term_data.typ_udalosti = 'WF' THEN term_data.mnozstvi_odv 
			ELSE NULL 
		END 
--		,'mnozstvi_nesh_v' = term_data.mnozstvi_nesh_v
--		,'mnozstvi_nesh_c' = term_data.mnozstvi_nesh_c
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
       KARATSQL.KARAT_TVD.[dba].[v_ter_in] imported_data with(readuncommitted),
       KARATSQL.KARAT_TVD.[dba].[zdr_poz] poz_zdroju with(readuncommitted)
       
       
  
  
  WHERE
	(	term_data.typ_udalosti = 'WS' 
	 OR term_data.typ_udalosti = 'WF' 
	) 
	 AND term_data.zdroj <> ''
	 AND term_data.id_vyr_oper = imported_data.id_vyr_oper
	 AND term_data.id_procesu = imported_data.id_procesu
	 AND term_data.typ_udalosti = imported_data.typ_udalosti
     AND term_data.stav = 1
     AND '1000000000' + CONVERT(VARCHAR, poz_zdroju.id_poz) = term_data.id_vyr_oper
     AND term_data.inc IN (SELECT Production_ID FROM dbo.Production with(readuncommitted) WHERE Production_ID = term_data.inc )
 ) y
		,dbo.Production z
WHERE z.Production_ID = y.Production_ID
AND z.UpdateTime < y.UpdateTime

--END /UPDATE TVD standardní zakázky



END







