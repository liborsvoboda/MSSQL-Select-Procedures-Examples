USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_Conditions]    Script Date: 15.4.2016 6:20:51 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[100_Export_VR_Conditions]
AS
BEGIN

--START OF Export VR Conditions

SELECT 
'INSERT INTO `tender_tenders_conditions` (karat_id,karat_item_id,sequence,required,text,variants)VALUES('+CHAR(39)

+uvp.doklad
+ CHAR(39)+',' + CAST (uvp.id AS VARCHAR)
+ ',' + CAST (uvp.poradi AS VARCHAR)
+ ',' + CAST (uvp.povinost AS VARCHAR)
+ ',' + CHAR(39) + uvp.[text]
+ CHAR(39)+ ',' + CHAR(39) + REPLACE(CAST(uvp.hodnota AS VARCHAR(MAX)), CHAR(13), '')
+ CHAR(39) +');'

FROM [dba].[user_vr_podminky] uvp
WHERE uvp.doklad = '1601010100000002' 

--END of EXPORT VR Conditions
    

END






GO


