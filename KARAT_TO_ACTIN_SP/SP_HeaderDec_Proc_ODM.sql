USE [TVD]
GO
/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Header_ODM_decomp]    Script Date: 05/06/2014 12:08:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






ALTER PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Header_ODM_decomp]
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

SELECT DISTINCT	
	 HeaderID = doklad.job					
	,DecompositionID = doklad.job
	,GroupID = doklad.zdroj
	,TimeBoard = CASE 
		WHEN doklad.staticky_rozklad = 0 THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(doklad.total_minut/60) AS varchar(2))+':'+CAST((FLOOR(doklad.total_minut)-(FLOOR(doklad.total_minut/60)*60)) AS varchar(2))+':'+CAST(FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST(((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) - FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(9)),108),2,7),108),108)
		ELSE CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR((doklad.total_minut/doklad.pocet)/60) AS varchar(2))+':'+CAST((FLOOR((doklad.total_minut/doklad.pocet)) - (FLOOR((doklad.total_minut/doklad.pocet)/60)*60)) AS varchar(2))+':'+CAST(FLOOR(((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST((((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) - FLOOR(((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) AS varchar(9)),108),2,7),108),108)
	END
	,BoardAmount = doklad.pocet					
	,UpdateTime = CASE 					
		   WHEN doklad.ts > odm_polozky.ts THEN doklad.ts				
		   WHEN odm_poz_polozky.ts > doklad.ts THEN odm_poz_polozky.ts				
		   ELSE odm_polozky.ts				
    END 
FROM KARATSQL.KARAT_TVD.dba.v_odm_nest_dkl doklad with(readuncommitted),KARATSQL.KARAT_TVD.dba.[v_odm_nest_pol] odm_polozky with(readuncommitted), KARATSQL.[KARAT_TVD].dba.[v_odm_poz_pol] odm_poz_polozky	with(readuncommitted)					
WHERE 						
doklad.doklad = odm_polozky.doklad						
AND doklad.storno = 0 						
--AND doklad.stav = 0						
AND doklad.stav = 1
AND odm_polozky.opv = odm_poz_polozky.opv						
AND odm_polozky.order_no = odm_poz_polozky.order_no						
AND odm_poz_polozky.storno = 0						
AND (odm_polozky.stav = 10 OR odm_polozky.stav = 20)						
AND doklad.job NOT IN (SELECT HeaderID COLLATE Czech_CI_AS FROM dbo.HeaderDecomposition WHERE HeaderID = doklad.job COLLATE Czech_CI_AS )
AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = doklad.zdroj COLLATE Czech_CI_AS OR DeviceID = doklad.zdroj COLLATE Czech_CI_AS)) = 1 
						
ORDER BY doklad.job						

-- END OF INSERT




--BEGIN / UPDATE TVD

UPDATE z SET 

	 z.DecompositionID = y.DecompositionID
	,z.GroupID = y.GroupID
	,z.TimeBoard = y.TimeBoard
	,z.BoardAmount = y.BoardAmount
	,z.UpdateTime = y.UpdateTime 					

FROM (

		SELECT DISTINCT						
			 HeaderID = doklad.job					
			,DecompositionID = doklad.job					
			,GroupID = doklad.zdroj
			,TimeBoard = CASE 
				WHEN doklad.staticky_rozklad = 0 THEN CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR(doklad.total_minut/60) AS varchar(2))+':'+CAST((FLOOR(doklad.total_minut)-(FLOOR(doklad.total_minut/60)*60)) AS varchar(2))+':'+CAST(FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST(((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) - FLOOR((doklad.total_minut - (FLOOR(doklad.total_minut)))*60) AS varchar(9)),108),2,7),108),108)
				ELSE CONVERT(time(7),CONVERT(VARCHAR(16),CAST(FLOOR((doklad.total_minut/doklad.pocet)/60) AS varchar(2))+':'+CAST((FLOOR((doklad.total_minut/doklad.pocet)) - (FLOOR((doklad.total_minut/doklad.pocet)/60)*60)) AS varchar(2))+':'+CAST(FLOOR(((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) AS varchar(2))+SUBSTRING(CONVERT(VARCHAR(8),CAST((((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) - FLOOR(((doklad.total_minut/doklad.pocet) - (FLOOR((doklad.total_minut/doklad.pocet))))*60) AS varchar(9)),108),2,7),108),108)
			END
			,BoardAmount = doklad.pocet					
			,UpdateTime = CASE 					
				   WHEN doklad.ts > odm_polozky.ts THEN doklad.ts				
				   WHEN odm_poz_polozky.ts > doklad.ts THEN odm_poz_polozky.ts				
				   ELSE odm_polozky.ts				
			END 						
		FROM KARATSQL.KARAT_TVD.dba.v_odm_nest_dkl doklad with(readuncommitted),KARATSQL.KARAT_TVD.dba.[v_odm_nest_pol] odm_polozky with(readuncommitted), KARATSQL.[KARAT_TVD].dba.[v_odm_poz_pol] odm_poz_polozky with(readuncommitted)						
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
		
		,dbo.HeaderDecomposition z
      
WHERE z.HeaderID COLLATE Czech_CI_AS  = y.HeaderID
AND z.UpdateTime < y.UpdateTime
-- END OF TVD UPDATE


END






