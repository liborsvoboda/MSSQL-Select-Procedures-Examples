USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_country]    Script Date: 06/15/2015 20:49:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_country](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country] [varchar](150) NOT NULL,
	[insert_date] [datetime] NOT NULL,
	[insert_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_120_country] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

