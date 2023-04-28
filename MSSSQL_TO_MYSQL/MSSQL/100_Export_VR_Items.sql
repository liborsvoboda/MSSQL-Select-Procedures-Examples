USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_Items]    Script Date: 15.4.2016 6:21:17 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[100_Export_VR_Items]
AS
BEGIN

--START OF Export VR Items

SELECT 
'INSERT INTO `tender_tenders_items` (karat_id,karat_item_id,nomenclature,name,attribute1,standard_size,din,amount,id_mj,required_stock)VALUES('+CHAR(39)

+ uvi.doklad
+ CHAR(39) +',' + CAST (uvi.polozka AS VARCHAR)
+ ',' + CHAR(39) + CAST (uvi.karta AS VARCHAR)
+ CHAR(39) + ',' + CHAR(39) + ISNULL((SELECT nom.nazev FROM dba.nomenklatura nom WHERE nom.id_nomen=uvi.id_karty),'')
+ CHAR(39) +',' + CHAR(39) + ISNULL(uvi.atribut,'')
+ CHAR(39) + ',' + CHAR(39) + ISNULL((SELECT nom.user_std_rozmer FROM dba.nomenklatura nom WHERE nom.id_nomen=uvi.id_karty),'')
+ CHAR(39) + ',' + CHAR(39) + ISNULL((SELECT nom.user_norma_din FROM dba.nomenklatura nom WHERE nom.id_nomen=uvi.id_karty),'')
+ CHAR(39) +',' + CAST (uvi.baleni AS VARCHAR)
+ ',' + CHAR(39) + CAST (RTRIM(uvi.id_mj) AS VARCHAR)
+ CHAR(39) +',' +  + CAST (uvi.min_mn AS VARCHAR)
+ ');'

FROM [dba].[user_vr_pol] uvi
WHERE uvi.doklad = '1601010100000002' 

--END of EXPORT VR Items
    

END








GO


