USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[100_customer_visit]    Script Date: 06/15/2015 20:46:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[100_customer_visit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ip_address] [varchar](20) NOT NULL,
	[sses_id] [varchar](250) NOT NULL,
	[visit_date] [datetime] NOT NULL,
	[domain] [varchar](250) NULL,
 CONSTRAINT [PK_100_customer_visit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

