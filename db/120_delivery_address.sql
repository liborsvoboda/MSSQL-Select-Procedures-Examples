USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_delivery_address]    Script Date: 06/15/2015 20:49:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_delivery_address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[delivery_address_name] [varchar](20) NOT NULL,
	[registration_id] [int] NOT NULL,
	[full_name] [varchar](200) NULL,
	[company] [varchar](250) NULL,
	[street] [varchar](150) NULL,
	[city] [varchar](150) NULL,
	[post_code] [varchar](50) NULL,
	[country] [varchar](150) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](250) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[create_ip] [varchar](50) NOT NULL,
	[update_date] [datetime] NULL,
	[update_ip] [varchar](50) NULL,
 CONSTRAINT [PK_120_delivery_address] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

