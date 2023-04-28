USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[100_dictionary]    Script Date: 06/15/2015 20:47:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[100_dictionary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[icon] [image] NULL,
	[mime_type] [varchar](20) NULL,
	[systemname] [varchar](50) NOT NULL,
	[lang_cs] [text] NULL,
	[lang_en] [text] NULL,
	[lang_de] [text] NULL,
	[lang_ru] [text] NULL,
 CONSTRAINT [PK_100_dictionary] PRIMARY KEY CLUSTERED 
(
	[systemname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

