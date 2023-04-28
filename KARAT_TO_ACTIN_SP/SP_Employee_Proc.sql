USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Employee]    Script Date: 04/29/2014 10:11:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_Employee]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Employee]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_Employee]    Script Date: 04/29/2014 10:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_Employee]
AS

BEGIN





--BEGIN / INSERT TVD

INSERT INTO dbo.Employee (
  EmployeeCode
 ,Barcode
 ,Name
 ,Surname
 ,UpdateTime
)

SELECT 	
  EmployeeCode = pers.oscislo	
 ,Barcode = ppom.kod_karty	
 ,Name = pers.jmeno	
 ,Surname = pers.prijmeni	
 ,UpdateTime = CASE	
	 WHEN pers.ts > ppom.ts THEN pers.ts
	 else ppom.ts 
 END	
 	
FROM {oj KARATSQL.KARAT_TVD.dba.pers pers with(readuncommitted)	
LEFT OUTER JOIN KARATSQL.KARAT_TVD.dba.ppom ppom with(readuncommitted) ON pers.oscislo = ppom.oscislo}	
WHERE pers.ppom_pp = ppom.pp 	
AND pers.ppom_poradipp = ppom.poradipp 	
AND ((pers.akt_stav In (0,10,20,30,35,40)) 	
AND (pers.prac_kateg='DEL'))	
AND pers.oscislo NOT IN (SELECT EmployeeCode COLLATE Czech_CI_AS FROM dbo.Employee WHERE EmployeeCode = pers.oscislo COLLATE Czech_CI_AS )

--END INSERT TVD
 
 
 
 
-- INSERT PGI

INSERT INTO dbo.Employee (
  EmployeeCode
 ,Barcode
 ,Name
 ,Surname
 ,UpdateTime
)

SELECT 	
  EmployeeCode = pers.oscislo	
 ,Barcode = ppom.kod_karty	
 ,Name = pers.jmeno	
 ,Surname = pers.prijmeni	
 ,UpdateTime = CASE	
	 WHEN pers.ts > ppom.ts THEN pers.ts
	 else ppom.ts 
 END	
 	
FROM {oj KARATSQL.KARAT_PGI.dba.pers pers with(readuncommitted) 	
LEFT OUTER JOIN KARATSQL.KARAT_PGI.dba.ppom ppom with(readuncommitted) ON pers.oscislo = ppom.oscislo}	
WHERE pers.ppom_pp = ppom.pp 	
AND pers.ppom_poradipp = ppom.poradipp 	
AND ((pers.akt_stav In (0,10,20,30,35,40)) 	
AND (pers.prac_kateg='DEL'))	
AND pers.oscislo NOT IN (SELECT EmployeeCode COLLATE Czech_CI_AS FROM dbo.Employee WHERE EmployeeCode = pers.oscislo COLLATE Czech_CI_AS )

-- END OF INSERT PGI







--BEGIN / UPDATE TVD

UPDATE z SET 

	 z.Barcode		=  y.Barcode
	,z.Name			=  y.Name
	,z.Surname		=  y.Surname
	,z.UpdateTime	=  y.UpdateTime
	
FROM (

		SELECT 	
		  EmployeeCode = pers.oscislo	
		 ,Barcode = ppom.kod_karty	
		 ,Name = pers.jmeno	
		 ,Surname = pers.prijmeni	
		 ,UpdateTime = CASE	
			 WHEN pers.ts > ppom.ts THEN pers.ts
			 else ppom.ts 
			 
		 END	
		 	
		FROM {oj KARATSQL.KARAT_TVD.dba.pers pers with(readuncommitted) 	
		LEFT OUTER JOIN KARATSQL.KARAT_TVD.dba.ppom ppom with(readuncommitted) ON pers.oscislo = ppom.oscislo}	
		WHERE pers.ppom_pp = ppom.pp 	
		AND pers.ppom_poradipp = ppom.poradipp 	
		AND ((pers.akt_stav In (0,10,20,30,35,40)) 	
		AND (pers.prac_kateg='DEL'))	
		) y
		,dbo.Employee z
      
WHERE z.EmployeeCode COLLATE Czech_CI_AS  = y.EmployeeCode
AND z.UpdateTime < y.UpdateTime

--END UPDATE TVD


--BEGIN / UPDATE PGI

UPDATE z SET 
	 z.Barcode		=  y.Barcode
	,z.Name			=  y.Name
	,z.Surname		=  y.Surname
	,z.UpdateTime	=  y.UpdateTime
	
FROM (

		SELECT 	
		  EmployeeCode = pers.oscislo	
		 ,Barcode = ppom.kod_karty	
		 ,Name = pers.jmeno	
		 ,Surname = pers.prijmeni	
		 ,UpdateTime = CASE	
			 WHEN pers.ts > ppom.ts THEN pers.ts
			 else ppom.ts 
			 
		 END	
		 	
		FROM {oj KARATSQL.KARAT_PGI.dba.pers pers with(readuncommitted) 	
		LEFT OUTER JOIN KARATSQL.KARAT_PGI.dba.ppom ppom with(readuncommitted) ON pers.oscislo = ppom.oscislo}	
		WHERE pers.ppom_pp = ppom.pp 	
		AND pers.ppom_poradipp = ppom.poradipp 	
		AND ((pers.akt_stav In (0,10,20,30,35,40)) 	
		AND (pers.prac_kateg='DEL'))	
		) y
		,dbo.Employee z
      
WHERE z.EmployeeCode COLLATE Czech_CI_AS  = y.EmployeeCode
AND z.UpdateTime < y.UpdateTime

--END / UPDATE PGI

END


GO


