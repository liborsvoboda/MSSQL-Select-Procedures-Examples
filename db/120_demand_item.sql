USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_demand_item]    Script Date: 06/15/2015 20:50:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_demand_item](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[demand_id] [varchar](50) NOT NULL,
	[record] [text] NOT NULL,
	[create_date] [datetime] NOT NULL,
	[ip_address] [varchar](20) NULL,
	[registration_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

