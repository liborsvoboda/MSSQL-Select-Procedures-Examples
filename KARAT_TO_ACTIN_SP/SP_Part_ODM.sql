USE [TVD]
GO
/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Part_ODM_decomp]    Script Date: 08/11/2014 06:48:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Part_ODM_decomp]
AS

BEGIN

--BEGIN / INSERT TVD

INSERT INTO dbo.PartDecomposition (
  HeaderID
 ,ContactId
 ,PartName
 ,PartAmount
 ,TimePart
 ,UpdateTime
)

SELECT 						
	 HeaderID = doklad.job					
	,ContactId = odm_polozky.opv					
	,PartName = odm_poz_polozky.postup_vyr					
	,PartAmount = odm_polozky.dilcu_v_roz	

	--xxxxx
	--CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(TimePart/60) AS varchar(2))+':'+CAST((FLOOR(doklad.total_minut)-(FLOOR(doklad.total_minut/60)*60)) AS varchar(2))+':'+CAST(FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST(((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) - FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(9)),108),2,7),108),108)
	--xxxxx					
,TimePart = (SELECT  CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60) AS varchar(2))+':'+CAST((FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))-(FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60)*60)) AS varchar(2))+':'+CAST(FLOOR(((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST((((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) - FLOOR(((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(9)),108),2,7),108),108)
					FROM KARATSQL.[KARAT_TVD].dba.v_opvoper opvoper with(readuncommitted) 	
					WHERE opvoper.opv = odm_polozky.opv	
						AND opvoper.operace_odm = 1
						AND opvoper.postup_pol = odm_poz_polozky.polozka_ope
						AND opvoper.poradi = odm_poz_polozky.poradi_vyr
						AND opvoper.postup = odm_poz_polozky.postup_vyr
				)		
	,UpdateTime = CASE 					
		   WHEN doklad.ts > odm_polozky.ts THEN doklad.ts				
		   WHEN odm_poz_polozky.ts > doklad.ts THEN odm_poz_polozky.ts				
		   ELSE odm_polozky.ts				
    END 						
FROM KARATSQL.[KARAT_TVD].dba.v_odm_nest_dkl doklad with(readuncommitted),KARATSQL.[KARAT_TVD].dba.[v_odm_nest_pol] odm_polozky with(readuncommitted), KARATSQL.[KARAT_TVD].dba.[v_odm_poz_pol] odm_poz_polozky with(readuncommitted)						
WHERE 						
doklad.doklad = odm_polozky.doklad						
AND doklad.storno = 0 						
AND doklad.stav = 1						
AND odm_polozky.opv = odm_poz_polozky.opv						
AND odm_polozky.order_no = odm_poz_polozky.order_no						
AND odm_poz_polozky.storno = 0						
AND (odm_polozky.stav = 10	OR odm_polozky.stav = 20)					
AND doklad.job+odm_polozky.opv+odm_poz_polozky.postup_vyr NOT IN (SELECT HeaderID+ContactId+PartName COLLATE Czech_CI_AS FROM dbo.PartDecomposition WHERE HeaderID = doklad.job COLLATE Czech_CI_AS )
AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = doklad.zdroj COLLATE Czech_CI_AS OR DeviceID = doklad.zdroj COLLATE Czech_CI_AS)) = 1 
AND ISNULL ((SELECT CONVERT(VARCHAR(16),CAST(FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60) AS varchar(2))+':'+CAST((FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))-(FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60)*60)) AS varchar(2))+':'+CAST(FLOOR(((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST((((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) - FLOOR(((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper1.tas + (opvoper1.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(9)),108),2,7),108)
					FROM KARATSQL.[KARAT_TVD].dba.v_opvoper opvoper1 with(readuncommitted) 	
					WHERE opvoper1.opv = odm_polozky.opv	
						AND opvoper1.operace_odm = 1
						AND opvoper1.postup_pol = odm_poz_polozky.polozka_ope
						AND opvoper1.poradi = odm_poz_polozky.poradi_vyr
						AND opvoper1.postup = odm_poz_polozky.postup_vyr
				),'FALSE') <> 'FALSE'
ORDER BY doklad.job						

-- END OF INSERT




--BEGIN / UPDATE TVD

UPDATE z SET 
  z.PartAmount	= y.PartAmount
 ,z.TimePart	= y.TimePart
 ,z.UpdateTime	= y.UpdateTime

FROM (
			SELECT 						
			 HeaderID   = doklad.job					
			,ContactId  = odm_polozky.opv					
			,PartName   = odm_poz_polozky.postup_vyr					
			,PartAmount = odm_polozky.dilcu_v_roz					
			,TimePart   = (SELECT  CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60) AS varchar(2))+':'+CAST((FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))-(FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1)))/60)*60)) AS varchar(2))+':'+CAST(FLOOR(((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST((((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) - FLOOR(((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))) - (FLOOR((opvoper.tas + (opvoper.tbs / ISNULL(odm_polozky.dilcu_v_roz,1))))))*60) AS varchar(9)),108),2,7),108),108)
								FROM KARATSQL.[KARAT_TVD].dba.v_opvoper opvoper with(readuncommitted) 	
								WHERE opvoper.opv = odm_polozky.opv	
									AND opvoper.operace_odm = 1
									AND opvoper.postup_pol = odm_poz_polozky.polozka_ope
									AND opvoper.poradi = odm_poz_polozky.poradi_vyr
									AND opvoper.postup = odm_poz_polozky.postup_vyr
							)		
			,UpdateTime = CASE 					
				   WHEN doklad.ts > odm_polozky.ts THEN doklad.ts				
				   WHEN odm_poz_polozky.ts > doklad.ts THEN odm_poz_polozky.ts				
				   ELSE odm_polozky.ts				
			END 						
		FROM KARATSQL.[KARAT_TVD].dba.v_odm_nest_dkl doklad with(readuncommitted),KARATSQL.[KARAT_TVD].dba.[v_odm_nest_pol] odm_polozky with(readuncommitted), KARATSQL.[KARAT_TVD].dba.[v_odm_poz_pol] odm_poz_polozky with(readuncommitted)						
		WHERE 						
		doklad.doklad = odm_polozky.doklad						
		AND doklad.storno = 0 						
		AND doklad.stav = 1						
		AND odm_polozky.opv = odm_poz_polozky.opv						
		AND odm_polozky.order_no = odm_poz_polozky.order_no						
		AND odm_poz_polozky.storno = 0						
		AND (odm_polozky.stav = 10 OR odm_polozky.stav = 20)
		AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = doklad.zdroj COLLATE Czech_CI_AS OR DeviceID = doklad.zdroj COLLATE Czech_CI_AS)) = 1 
		) y
		,dbo.PartDecomposition z
WHERE 
	z.HeaderID COLLATE Czech_CI_AS = y.HeaderID
AND	z.ContactId COLLATE Czech_CI_AS = y.ContactId
AND	z.PartName COLLATE Czech_CI_AS = y.PartName
AND z.UpdateTime < y.UpdateTime

-- END OF TVD UPDATE


END






