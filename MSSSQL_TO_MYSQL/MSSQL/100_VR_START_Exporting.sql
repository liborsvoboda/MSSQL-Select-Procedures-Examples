USE [KARAT_TVD]
GO

/****** Object:  StoredProcedure [dbo].[100_VR_START_Exporting]    Script Date: 15.4.2016 6:21:59 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[100_VR_START_Exporting]
AS
BEGIN

DECLARE @cmd varchar(1000)

--START OF Export VR Header
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_header]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Header.exp" -c -UTF8 -T -Slocalhost'

	--SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_header]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Header.exp" -c -C1250 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Header
    

--START OF Export VR Conditions
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_Conditions]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Condition.exp" -c -UTF8 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Conditions


--START OF Export VR Suppliers
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_Users]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier.exp" -c -UTF8 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Suppliers

--START OF Export VR Suppliers_bridge
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_Users_bridge]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Supplier_brg.exp" -c -UTF8 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Suppliers_bridge


--START OF Export VR Attachments
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_Attachments]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Attachment.exp" -c -UTF8 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Attachments


--START OF Export VR Items
	SET @cmd = 'bcp "EXEC [KARAT_TVD].[dbo].[100_Export_VR_Items]" queryout "\\tvd-karatapp01\vzor\_firm\USER_VR\DATA\Item.exp" -c -UTF8 -T -Slocalhost'
EXEC master..xp_cmdshell @cmd
--END of EXPORT VR Items




END








GO


