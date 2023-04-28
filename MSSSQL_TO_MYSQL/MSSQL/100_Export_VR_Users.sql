USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_Users]    Script Date: 15.4.2016 6:21:29 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[100_Export_VR_Users]
AS
BEGIN

--START OF Export VR Users

SELECT 

--'INSERT INTO `tender_users` (karat_idp,company_name,email,password)VALUES('+CHAR(39) 
--+ uvd.id_partnera
--+ CHAR(39)+',' + CHAR(39) + COALESCE((SELECT parcis.nazev FROM dba.parcis parcis WHERE parcis.id_partnera = uvd.id_partnera),'')
--+ CHAR(39)+',' + CHAR(39) + uvd.e_mail
--+ CHAR(39)+',' + CHAR(39) + 
--+ CHAR(39) +');'


'CALL `sr_check_tender_user`('+CHAR(39)
+ uvd.id_partnera
+ CHAR(39)+',' + CHAR(39) + COALESCE((SELECT parcis.nazev FROM dba.parcis parcis WHERE parcis.id_partnera = uvd.id_partnera),'')
+ CHAR(39)+',' + CHAR(39) + uvd.e_mail
+ CHAR(39) +');'

FROM dba.user_vr_dodavatele uvd
WHERE uvd.doklad = '1601010100000002' 

--END of EXPORT VR Users

END

GO


