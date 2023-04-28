USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_Export_VR_Attachments]    Script Date: 15.4.2016 6:20:15 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[100_Export_VR_Attachments]
AS
BEGIN

--START OF Export VR Attachments

SELECT 
'INSERT INTO `tender_tenders_files` (karat_id,file_name,mime_type,file_content)VALUES('+CHAR(39)
+ uvd.doklad
+ CHAR(39) + ',' + CHAR(39) + ISNULL(CAST(at_store.file_name AS VARCHAR(255)),'')
+ CHAR(39) + ',' + CHAR(39) + CASE 
    WHEN LEFT(convert(varbinary(8), attachments.xbin),2)=0x424D THEN 'image/bmp' 
    WHEN LEFT(convert(varbinary(8), attachments.xbin),2)=0xFFD8 THEN 'image/jpeg' 
    WHEN LEFT(convert(varbinary(8), attachments.xbin),2)=0x2550 THEN 'application/pdf' 
    WHEN LEFT(convert(varbinary(8), attachments.xbin),2)=0xD0CF THEN 'application/msword' 
    WHEN LEFT(convert(varbinary(8), attachments.xbin),8)=0x89504E470D0A1A0A THEN 'image/png' 
    WHEN (LEFT(convert(varbinary(8), attachments.xbin),2)=0x4949) OR (LEFT(convert(varbinary(8), attachments.xbin),2)=0x4D4D) THEN 'image/tiff' 
    ELSE '' 
END
+ CHAR(39) + ','  + ISNULL((CONVERT(varchar(max),CONVERT(VARBINARY(MAX),attachments.xbin),1)),NULL)
+ ');'
 FROM dba.user_vr_dkl uvd,[dba].[attach_store] at_store,  [KARAT_TVD_ATT].[dba].[binaries] attachments 
 WHERE 

 at_store.ext_blob_id = attachments.id
 AND at_store.tabulka = 'user_vr_dkl'
 AND at_store.pk = uvd.doklad
 AND uvd.doklad = '1601010100000002'

--END of EXPORT VR Attachments
END


GO


