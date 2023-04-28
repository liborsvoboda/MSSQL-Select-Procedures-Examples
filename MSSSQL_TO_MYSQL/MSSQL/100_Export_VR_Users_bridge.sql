USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_Users_bridge]    Script Date: 15.4.2016 6:21:47 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[100_Export_VR_Users_bridge]
AS
BEGIN

--START OF Export VR Users bridge

SELECT 

'CALL `sr_generate_password`;
INSERT INTO `tender_users_tenders` (karat_id,karat_idp,terms,finished,note)VALUES('+CHAR(39) 
+ uvd.doklad 
+ CHAR(39)+',' + CHAR(39) + uvd.id_partnera
+ CHAR(39)+',0' 
+',0'
+',' + CHAR(39)
+ CHAR(39) +');'

FROM dba.user_vr_dodavatele uvd
WHERE uvd.doklad = '1601010100000002' 

--END of EXPORT VR Users bridge

END


GO


