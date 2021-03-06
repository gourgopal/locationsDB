USE [XYZ]
GO
/****** Object:  Table [loc].[locations]    Script Date: 01-18-2018 16:16:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [loc].[locations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[place_name] [varchar](200) NOT NULL,
	[region_name] [varchar](200) NULL,
	[latitude] [decimal](12, 9) NULL,
	[longitude] [decimal](12, 9) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
