USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[100_login]    Script Date: 06/15/2015 20:47:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[100_login](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login_name] [varchar](20) NOT NULL,
	[login_pw] [varbinary](max) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[language] [varchar](20) NOT NULL,
	[last_login] [datetime] NOT NULL,
 CONSTRAINT [PK_100_login] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

