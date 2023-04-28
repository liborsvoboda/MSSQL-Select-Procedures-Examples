USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_demand_header]    Script Date: 06/15/2015 20:50:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_demand_header](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[demand_id] [varchar](50) NOT NULL,
	[registration_id] [int] NULL,
	[creation_date] [datetime] NOT NULL,
	[ip_address] [varchar](20) NULL,
	[customer_name] [varchar](200) NOT NULL,
	[company] [varchar](250) NULL,
	[ico] [varchar](20) NULL,
	[dic] [varchar](20) NULL,
	[street] [varchar](150) NOT NULL,
	[city] [varchar](150) NOT NULL,
	[post_code] [varchar](50) NULL,
	[country] [varchar](150) NULL,
	[phone] [varchar](50) NOT NULL,
	[email] [varchar](250) NOT NULL,
	[discount] [float] NULL,
	[shipping] [varchar](20) NOT NULL,
	[payment_terms] [varchar](20) NOT NULL,
	[merchant_note] [text] NULL,
	[delivery_full_name] [varchar](200) NULL,
	[delivery_company] [varchar](250) NULL,
	[delivery_street] [varchar](150) NULL,
	[delivery_city] [varchar](150) NULL,
	[delivery_post_code] [varchar](50) NULL,
	[delivery_country] [varchar](150) NULL,
	[delivery_phone] [varchar](50) NULL,
	[delivery_email] [varchar](250) NULL,
	[html_file] [text] NULL,
 CONSTRAINT [PK_120_demand_header] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

