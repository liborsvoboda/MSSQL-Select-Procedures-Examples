USE [KARAT_TVD]
GO

/****** Object:  Table [dbo].[100_model]    Script Date: 06/15/2015 20:48:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[100_model](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[data_type] [varchar](20) NOT NULL,
	[systemname] [varchar](100) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[creator] [varchar](20) NOT NULL,
	[sequence] [int] NULL,
	[parent_data_type] [varchar](20) NULL,
	[icon] [varbinary](max) NULL,
	[mime_type] [varchar](20) NULL,
	[system_function] [bit] NULL,
	[ckeditor_cs] [text] NULL,
	[ckeditor_en] [text] NULL,
	[ckeditor_de] [text] NULL,
	[ckeditor_ru] [text] NULL,
 CONSTRAINT [PK_100_model] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

