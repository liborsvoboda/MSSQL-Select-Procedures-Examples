USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[120_registration]    Script Date: 06/15/2015 20:50:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[120_registration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login_name] [varchar](20) NOT NULL,
	[login_password] [varbinary](max) NOT NULL,
	[full_name] [varchar](200) NULL,
	[company] [varchar](250) NULL,
	[ico] [varchar](20) NULL,
	[dic] [varchar](20) NULL,
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
	[shipping] [varchar](20) NULL,
	[payment_terms] [varchar](20) NULL,
	[last_login] [datetime] NULL,
	[blocked] [bit] NULL,
 CONSTRAINT [ID_Primary_key] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_login_name] UNIQUE NONCLUSTERED 
(
	[login_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[120_registration] ADD  CONSTRAINT [DF_120_registration_blocked]  DEFAULT ((0)) FOR [blocked]
GO

