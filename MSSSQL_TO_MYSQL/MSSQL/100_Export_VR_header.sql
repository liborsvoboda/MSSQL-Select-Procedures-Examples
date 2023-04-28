USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_header]    Script Date: 15.4.2016 6:21:06 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[100_Export_VR_header]
AS
BEGIN

--START OF Export VR Header

SELECT 

'INSERT INTO `tender_tenders` (karat_id,name,start_date,end_date,header_text,footer_text,
resp_person,currency,exchange_rate,estimated_price,description)VALUES('+CHAR(39) 

+ uvd.doklad 
+ CHAR(39)+',' + CHAR(39) + uvd.nazev
+ CHAR(39)+',' + CHAR(39) + CAST(CONVERT(DATE,uvd.dat_zah,106) as VARCHAR) + ' ' + CAST(CAST(uvd.dat_zah as TIME(0)) AS VARCHAR)
+ CHAR(39)+',' + CHAR(39) + CAST(CONVERT(DATE,uvd.dat_kon,106) as VARCHAR) + ' ' + CAST(CAST(uvd.dat_kon as TIME(0)) AS VARCHAR)
+ CHAR(39)+',' + CHAR(39) + REPLACE(CAST(uvd.t_uvod AS VARCHAR(MAX)), CHAR(13), '<br>')
+ CHAR(39)+',' + CHAR(39) + REPLACE(CAST(uvd.t_zaver AS VARCHAR(MAX)), CHAR(13), '<br>')
+ CHAR(39)+',' + CHAR(39) + COALESCE((SELECT prijmeni +' ' + jmeno FROM dba.osoby0 WHERE id_osoby = uvd.id_par_tvd),'')
+ CHAR(39)+',' + CHAR(39) + uvd.id_meny
+ CHAR(39)+',' + CAST(CAST ((CASE WHEN uvd.mnozstvi <> 0 THEN uvd.kurz / uvd.mnozstvi ELSE uvd.kurz END) AS decimal (16,4)) as VARCHAR)
+ ',' + CAST(CAST (uvd.cena_bez_dph AS decimal (16,4)) as VARCHAR)
+ ',' + CHAR(39) + REPLACE(CAST(uvd.t_uvod AS VARCHAR(MAX)), CHAR(13), '<br>')
+ CHAR(39) +');'

FROM dba.user_vr_dkl uvd
WHERE uvd.doklad = '1601010100000002' 


--END of EXPORT VR Header
    

END







GO


