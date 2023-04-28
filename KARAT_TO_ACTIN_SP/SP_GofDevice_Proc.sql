USE [TVD]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_GroupOfDevice]    Script Date: 09/18/2014 07:16:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_GroupOfDevice]
AS

BEGIN

--BEGIN / INSERT TVD
INSERT INTO dbo.[GroupOfDevice] (
	 [GroupID]
	,[DeviceID]
	,[UpdateTime]
)

SELECT 
	 'GroupID' = CASE
		WHEN zdroj.user_cislo_skup ='' THEN zdroj.zdroj
		WHEN zdroj.user_cislo_skup ='0' THEN zdroj.zdroj
		ELSE zdroj.user_cislo_skup		
	 END
	,'DeviceID' = zdroj.zdroj
	,'UpdateTime' = zdroj.ts
FROM KARATSQL.KARAT_TVD.dba.zdr_zdr zdroj with(readuncommitted)
where zdroj.zdroj <>''
AND zdroj.zdroj NOT IN (SELECT [DeviceID] COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE [DeviceID] = zdroj.zdroj COLLATE Czech_CI_AS AND [GroupID] = CASE
		WHEN zdroj.user_cislo_skup ='' THEN zdroj.zdroj
		WHEN zdroj.user_cislo_skup ='0' THEN zdroj.zdroj
		ELSE zdroj.user_cislo_skup		
	 END COLLATE Czech_CI_AS)
	 
--AND zdroj.zdroj IN ('2327530','2327531','2331214','2331215','2331216','2331217','2338263','2338264','2338266','2338267','2338268','2338269','2343001','2958360','2958361','2958362','2331218','2331219')
AND zdroj.zdroj	IN (SELECT [EXT_REFERENCE] COLLATE Czech_CI_AS FROM [TVD].[dbo].[PE002] WHERE [EXT_REFERENCE] <> '' AND [EXT_REFERENCE] <> 'NULL')
ORDER BY zdroj.zdroj
--END INSERT TVD
 
 
 
 





--BEGIN / UPDATE TVD
UPDATE z SET 
	 z.[GroupID]		  = y.GroupID
	,z.[UpdateTime]		  = y.UpdateTime

FROM (
		SELECT 
			 'GroupID' = CASE
				WHEN zdroj.user_cislo_skup ='' THEN zdroj.zdroj
				WHEN zdroj.user_cislo_skup ='0' THEN zdroj.zdroj
				ELSE zdroj.user_cislo_skup		
			 END
			,'DeviceID' = zdroj.zdroj
			,'UpdateTime' = zdroj.ts
		FROM KARATSQL.KARAT_TVD.dba.zdr_zdr zdroj with(readuncommitted)
		WHERE zdroj.zdroj <>''
        AND (SELECT DISTINCT '1' COLLATE Czech_CI_AS FROM dbo.GroupOfDevice WHERE (GroupID = zdroj.zdroj COLLATE Czech_CI_AS OR DeviceID = zdroj.zdroj COLLATE Czech_CI_AS)) = 1 
		) y
		,dbo.[GroupOfDevice] z
      
WHERE z.[DeviceID] COLLATE Czech_CI_AS  = y.[DeviceID]
AND z.UpdateTime < y.UpdateTime

--END UPDATE TVD



END







GO


