USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_product_search]    Script Date: 06/15/2015 20:50:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_product_search](
	[product_group] [varchar](20) NOT NULL,
	[model] [varchar](100) NOT NULL,
	[karat_catalog_mark] [varchar](50) NOT NULL,
	[karat_inernal_no] [varchar](50) NOT NULL,
	[sizes] [varchar](50) NOT NULL,
	[update_time] [datetime] NOT NULL,
	[update_user] [varchar](20) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

