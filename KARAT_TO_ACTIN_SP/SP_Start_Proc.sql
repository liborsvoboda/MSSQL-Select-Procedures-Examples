USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_START]    Script Date: 04/29/2014 10:11:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_KARAT_TO_ACTIN_START]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_START]
GO

USE [TVD_TEST2]
GO

/****** Object:  StoredProcedure [dbo].[SP_KARAT_TO_ACTIN_START]    Script Date: 04/29/2014 10:11:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_KARAT_TO_ACTIN_START]
AS
BEGIN

	EXEC dbo.SP_KARAT_TO_ACTIN_GroupOfDevice
	EXEC dbo.SP_KARAT_TO_ACTIN_Employee
	EXEC dbo.SP_KARAT_TO_ACTIN_Shift
	EXEC dbo.SP_KARAT_TO_ACTIN_Header_ODM_decomp
	EXEC dbo.SP_KARAT_TO_ACTIN_Part_ODM_decomp
--	EXEC dbo.SP_KARAT_TO_ACTIN_Production_ODM
	EXEC SP_KARAT_TO_ACTIN_Header_STD_decomp
	EXEC SP_KARAT_TO_ACTIN_Part_STD_decomp

END








GO


